//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

protocol ResourceScanning {
  static var fileExtensions: [String] { get }

  var filesToScan: [File] { get set }

  mutating func appendIfScannable(file: File)
  func canScan(file: File) -> Bool
  func scanFiles() -> Set<ScanResult>
  func scan(file: File) -> Set<ScanResult>
}

extension ResourceScanning {
  mutating func appendIfScannable(file: File) {
    guard canScan(file: file) else { return }

    filesToScan.append(file)
  }

  func canScan(file: File) -> Bool {
    guard let fileExtension = file.extension else { return false }

    return type(of: self).fileExtensions.contains(fileExtension)
  }

  func scanFiles() -> Set<ScanResult> {
    var results = Set<ScanResult>()
    for fileToScan in filesToScan { results.formUnion(scan(file: fileToScan)) }
    return results
  }
}
