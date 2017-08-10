//
//  The MIT License (MIT)
//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

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
        guard canScan(file: file) else {
            return
        }

        filesToScan.append(file)
    }

    func canScan(file: File) -> Bool {
        guard let fileExtension = file.extension else {
            return false
        }

        return type(of: self).fileExtensions.contains(fileExtension)
    }

    func scanFiles() -> Set<ScanResult> {
        var results = Set<ScanResult>()

        for fileToScan in filesToScan {
            results.formUnion(scan(file: fileToScan))
        }

        return results
    }
}
