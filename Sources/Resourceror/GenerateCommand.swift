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

import Foundation
import ResourcerorCore
import SwiftCLI

class GenerateCommand: Command {
    let name = "generate"
    let shortDescription = "Generates a list of images, XIB and Storyboard files and their contained identifiers"

    let sourceDirectory = OptionalParameter()
    let excludedPathNames = Key<String>("-e", "--exclude", usage: "Comma separated list of directory or file names to exclude")

    private let generator = ResourceListGenerator()
    private let currentWorkingDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    func execute() throws {
        // If no path has been passed on the command line, use the current working directory as the path to scan.
        let pathToScan = sourceDirectory.value ?? "."
        let urlToScan = URL(fileURLWithPath: pathToScan, isDirectory: true, relativeTo: currentWorkingDirectoryURL)
        precondition(urlToScan.isFileURL, "\(urlToScan) is not a valid file URL!")

        // Split the list of excluded directory names into an array of names
        let excludedDirectories: [String] = excludedPathNames.value?.split(separator: ",").flatMap { String($0) } ?? []

        // Everything is ready, scan the passed file URL
        try generator.scanDirectory(at: urlToScan, excluding: excludedDirectories)
    }
}
