//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class AudioFileScanner: ResourceScanning {
  static let itemExtensions = ["aif", "aiff", "mp3", "mp4", "m4a", "m4p"]

  var itemsToScan = [FileSystem.Item]()

  func scan(item: FileSystem.Item) -> Set<ScanResult> { return [ScanResult(type: .audio, identifier: item.nameExcludingExtension)] }
}
