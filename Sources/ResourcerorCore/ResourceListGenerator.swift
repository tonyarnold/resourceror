//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import Regex

public final class ResourceListGenerator {
  public init() {}

  let scanners: [ResourceScanning] = [StoryboardScanner(), InterfaceBuilderDocumentScanner(), ImageFileScanner(), AudioFileScanner(),]

  public func scanDirectory(at url: URL, excluding: [String] = []) throws {
    try updateScannables(at: url, excluding: excluding)

    let results: Set<ScanResult> = scanners.reduce([]) { $0.union($1.scanFiles()) }
    let groupedResults = Dictionary(grouping: results, by: { $0.type }).sorted { lhs, rhs -> Bool in
      return lhs.key.rawValue.lexicographicallyPrecedes(rhs.key.rawValue)
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
    let folders = try Folder(path: url.path).makeSubfolderSequence(recursive: false, includeHidden: false)

    for folder in folders where excluding.contains(folder.name) == false {
      for file in folder.files where excluding.contains(file.name) == false { for var scanner in scanners { scanner.appendIfScannable(file: file) } }

      let folderURL = URL(fileURLWithPath: folder.path, isDirectory: true)
      try updateScannables(at: folderURL, excluding: excluding)
    }
  }
}
