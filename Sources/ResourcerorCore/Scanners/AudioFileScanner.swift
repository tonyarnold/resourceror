//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class AudioFileScanner: FolderScanning {
  static let requestedPathExtensions = ["aif", "aiff", "mp3", "mp4", "m4a", "m4p"]

  var itemsToScan: [Folder] = []

  func scan(item: Folder) -> Set<ScanResult> {
    [ScanResult(type: .audio, identifier: item.nameExcludingExtension)]
  }
}
