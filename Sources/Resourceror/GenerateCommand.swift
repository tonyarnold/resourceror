//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation
import ResourcerorCore
import SwiftCLI

class GenerateCommand: Command {
    enum Error: Swift.Error {
        case notFileURL(URL)
    }

    let name = "generate"
    let shortDescription = "Generates a list of images, XIB and Storyboard files and their contained identifiers"

    let sourceDirectory = OptionalParameter()
    let excludedPathNames = Key<String>("-e", "--exclude", description: "Comma separated list of directory or file names to exclude")

    private let generator = ResourceListGenerator()
    private let currentWorkingDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    func execute() throws {
        // If no path has been passed on the command line, use the current working directory as the path to scan.
        let pathToScan = sourceDirectory.value ?? "."
        let urlToScan = URL(fileURLWithPath: pathToScan, isDirectory: true, relativeTo: currentWorkingDirectoryURL)

        guard urlToScan.isFileURL else {
            throw Error.notFileURL(urlToScan)
        }

        // Split the list of excluded directory names into an array of names
        let excludedDirectories: [String] = excludedPathNames.value?.split(separator: ",").compactMap { String($0) } ?? []

        // Everything is ready, scan the passed file URL
        try generator.scanDirectory(at: urlToScan, excluding: excludedDirectories)
    }
}
