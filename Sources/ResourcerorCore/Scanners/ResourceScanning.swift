//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

protocol FileContentsScanning {
  static var requestedPathExtensions: [String] { get }
  var itemsToScan: [File] { get set }

  mutating func appendIfScannable(item: File)
  func canScan(item: File) -> Bool
  func scanFileSystem() -> Set<ScanResult>
  func scan(item: File) -> Set<ScanResult>
}

extension FileContentsScanning {
  mutating func appendIfScannable(item: File) {
    guard canScan(item: item) else {
      return
    }

    itemsToScan.append(item)
  }

  func canScan(item: File) -> Bool {
    guard let pathExtension = item.extension else { return false }

    return type(of: self).requestedPathExtensions.contains(pathExtension)
  }

  func scanFileSystem() -> Set<ScanResult> {
    return itemsToScan
      .map(scan(item:))
      .reduce(into: Set<ScanResult>()) { $0.formUnion($1) }
  }
}

protocol FolderScanning {
  static var requestedPathExtensions: [String] { get }
  var itemsToScan: [Folder] { get set }

  mutating func appendIfScannable(item: Folder)
  func canScan(item: Folder) -> Bool
  func scanFileSystem() -> Set<ScanResult>
  func scan(item: Folder) -> Set<ScanResult>
}

extension FolderScanning {
  mutating func appendIfScannable(item: Folder) {
    guard canScan(item: item) else {
      return
    }

    itemsToScan.append(item)
  }

  func canScan(item: Folder) -> Bool {
    guard let pathExtension = item.extension else { return false }

    return type(of: self).requestedPathExtensions.contains(pathExtension)
  }

  func scanFileSystem() -> Set<ScanResult> {
    return itemsToScan
      .map(scan(item:))
      .reduce(into: Set<ScanResult>()) { $0.formUnion($1) }
  }
}
