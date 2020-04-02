//  Copyright © 2019 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import os.log
import Regex

final class AssetCatalogScanner: FolderScanning {
  static let requestedPathExtensions = ["xcassets"]

  var itemsToScan: [Folder] = []

  func scan(item: Folder) -> Set<ScanResult> {
    let results = try? item.subfolders.recursive
      .filter { $0.extension == "colorset" || $0.extension == "imageset" }
      .compactMap(scanCatalog(folder:))

    return Set(results ?? [])
  }

  private func scanAssetGroup(folder: Folder) throws -> String? {
    // Determine if this asset group defines a namespace
    let contentsFile = try folder.file(named: "Contents.json")
    let contentsData = try contentsFile.read()
    let metadata = try JSONDecoder().decode(AssetMetadata.self, from: contentsData)
    return metadata.providesNamespace ? folder.name : nil
  }

  private func scanCatalog(folder: Folder) throws -> ScanResult? {
    let parentFolders = sequence(first: folder) { element in
      guard
        let itemExtension = element.extension,
        AssetCatalogScanner.requestedPathExtensions.contains(itemExtension)
      else {
        return element.parent
      }

      return nil
    }

    let prefix = try parentFolders
      .compactMap { try self.scanAssetGroup(folder: $0) }
      .joined(separator: "/")

    let identifier: String
    if prefix.isEmpty {
      identifier = folder.nameExcludingExtension
    } else {
      identifier = prefix + "/" + folder.nameExcludingExtension
    }

    let type: ResultType = folder.extension == "colorset" ? .namedColor : .image
    return ScanResult(type: type, identifier: identifier)
  }
}

private struct AssetMetadata: Decodable {
  var providesNamespace: Bool {
    return properties?.providesNamespace ?? false
  }

  private let properties: Properties?

  enum CodingKeys: String, CodingKey {
    case properties
  }

  private struct Properties: Decodable {
    let providesNamespace: Bool?

    private enum CodingKeys: String, CodingKey {
      case providesNamespace = "provides-namespace"
    }
  }
}
