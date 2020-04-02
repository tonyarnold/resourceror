//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class ImageFileScanner: FolderScanning {
  static let requestedPathExtensions = ["png", "jpg", "jpeg", "pdf", "jp2"]

  var itemsToScan: [Folder] = []

  func scan(item: Folder) -> Set<ScanResult> {
    let folderName: String
    if let range = item.nameExcludingExtension.range(of: "@2x") { folderName = String(item.nameExcludingExtension[..<range.lowerBound]) }
    else { folderName = item.nameExcludingExtension }

    return [ScanResult(type: .image, identifier: folderName)]
  }
}
