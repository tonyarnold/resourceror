//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class ImageFileScanner: ResourceScanning {
  static let itemExtensions = ["png", "jpg", "jpeg", "pdf", "jp2"]

  var itemsToScan = [FileSystem.Item]()

  func scan(item: FileSystem.Item) -> Set<ScanResult> {
    let itemName: String
    if let range = item.nameExcludingExtension.range(of: "@2x") { itemName = String(item.nameExcludingExtension[..<range.lowerBound]) }
    else { itemName = item.nameExcludingExtension }

    return [ScanResult(type: .image, identifier: itemName)]
  }
}
