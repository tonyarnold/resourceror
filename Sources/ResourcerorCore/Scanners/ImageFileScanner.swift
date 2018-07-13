//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation

final class ImageFileScanner: ResourceScanning {
    static let fileExtensions = ["png", "jpg", "jpeg", "pdf", "jp2"]

    var filesToScan = [File]()

    func scan(file: File) -> Set<ScanResult> {
        let fileName: String
        if let range = file.nameExcludingExtension.range(of: "@2x") {
            fileName = String(file.nameExcludingExtension[..<range.lowerBound])
        } else {
            fileName = file.nameExcludingExtension
        }

        return [ScanResult(type: .image, identifier: fileName)]
    }
}
