//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class AudioFileScanner: ResourceScanning {
  static let fileExtensions = ["aif", "aiff", "mp3", "mp4", "m4a", "m4p",]

  var filesToScan = [File,]()

  func scan(file: File) -> Set<ScanResult> { return [ScanResult(type: .audio, identifier: file.nameExcludingExtension),] }
}
