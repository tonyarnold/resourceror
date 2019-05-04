//  Copyright © 2019 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import os.log
import Regex

final class AssetCatalogScanner: ResourceScanning {
  static let itemExtensions = ["xcassets"]

  var itemsToScan: [FileSystem.Item] = []

  func scan(item: FileSystem.Item) -> Set<ScanResult> {
    guard let folder = item as? Folder else {
      return []
    }

    let results = try? folder.makeSubfolderSequence(recursive: true, includeHidden: false)
      .filter { $0.extension == "colorset" || $0.extension == "imageset" }
      .compactMap { try self.scanCatalog(folder: $0) }

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
    let parentFolders = folder.parents(upTo: { item in
      guard let itemExtension = item.extension else {
        return false
      }

      return AssetCatalogScanner.itemExtensions.contains(itemExtension)
    })
      .compactMap { $0 as? Folder }

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
