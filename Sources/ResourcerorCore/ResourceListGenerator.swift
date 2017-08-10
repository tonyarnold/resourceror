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
import Regex

public final class ResourceListGenerator {

    public init() {}

    let scanners: [ResourceScanning] = [
        StoryboardScanner(),
        InterfaceBuilderDocumentScanner(),
        ImageFileScanner()
    ]

    public func scanDirectory(at url: URL) throws {
        try Folder(path: url.path).makeSubfolderSequence(recursive: true, includeHidden: false).forEach { folder in
            for file in folder.files {
                for var scanner in scanners {
                    scanner.appendIfScannable(file: file)
                }
            }
        }

        let results: Set<ScanResult> = scanners.reduce([]) { $0.union($1.scanFiles()) }
        let groupedResults = Dictionary(grouping: results, by: { $0.type }).sorted { lhs, rhs -> Bool in
            return lhs.key.rawValue.lexicographicallyPrecedes(rhs.key.rawValue)
        }

        for (type, results) in groupedResults {
            print("extension \(type.rawValue) {")
            results
                .sorted { lhs, rhs in lhs.identifier.lexicographicallyPrecedes(rhs.identifier) }
                .forEach {
                    print("\t\($0.outputLine)")
                }
            print("}\n")
        }
    }
}
