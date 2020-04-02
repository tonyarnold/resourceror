//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import Regex

public final class ResourceListGenerator {
  public init() {}

  let fileContentsScanners: [FileContentsScanning] = [StoryboardScanner(), InterfaceBuilderDocumentScanner()]
  let folderScanners: [FolderScanning] = [ImageFileScanner(), AudioFileScanner(), AssetCatalogScanner()]

  public func scanDirectory(at url: URL, excluding: [String] = []) throws {
    try updateScannables(at: url, excluding: excluding)
    let fileResults: Set<ScanResult> = fileContentsScanners.reduce(into: []) { $0.formUnion($1.scanFileSystem()) }
    let folderResults: Set<ScanResult> = folderScanners.reduce(into: []) { $0.formUnion($1.scanFileSystem()) }
    let groupedResults = Dictionary(grouping: fileResults.union(folderResults), by: { $0.type }).sorted { lhs, rhs -> Bool in
      lhs.key.rawValue.lexicographicallyPrecedes(rhs.key.rawValue)
    }

    for (type, results) in groupedResults {
      print("extension \(type.rawValue) {")
      results.sorted { lhs, rhs in
        lhs.identifier.lexicographicallyPrecedes(rhs.identifier)
      }.forEach { print("  \($0.outputLine)") }
      print("}\n")
    }
  }

  private func updateScannables(at url: URL, excluding: [String]) throws {
    let root = try Folder(path: url.path)
    try updateScannables(in: root, excluding: excluding)
  }

  private func updateScannables(in folder: Folder, excluding: [String]) throws {
    guard excluding.contains(folder.name) == false else {
      return
    }

    folder.files
      .filter { excluding.contains($0.name) == false }
      .forEach {
        for var scanner in fileContentsScanners { scanner.appendIfScannable(item: $0) }
      }

    try folder.subfolders.forEach {
      for var scanner in folderScanners { scanner.appendIfScannable(item: $0) }

      try self.updateScannables(in: $0, excluding: excluding)
    }
  }
}
