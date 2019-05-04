//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

protocol ResourceScanning {
  static var itemExtensions: [String] { get }

  var itemsToScan: [FileSystem.Item] { get set }

  mutating func appendIfScannable(item: FileSystem.Item)
  func canScan(item: FileSystem.Item) -> Bool
  func scanFileSystem() -> Set<ScanResult>
  func scan(item: FileSystem.Item) -> Set<ScanResult>
}

extension ResourceScanning {
  mutating func appendIfScannable(item: FileSystem.Item) {
    guard canScan(item: item) else {
      return
    }
    itemsToScan.append(item)
  }

  func canScan(item: FileSystem.Item) -> Bool {
    guard let fileExtension = item.extension else { return false }

    return type(of: self).itemExtensions.contains(fileExtension)
  }

  func scanFileSystem() -> Set<ScanResult> {
    return itemsToScan
      .map {
        return self.scan(item: $0)
      }
      .reduce(into: Set<ScanResult>()) { $0.formUnion($1) }
  }
}
