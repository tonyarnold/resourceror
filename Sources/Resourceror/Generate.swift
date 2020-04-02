//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import ArgumentParser
import Foundation
import ResourcerorCore

struct Generate: ParsableCommand {
    static var configuration
        = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates a list of images, XIB and Storyboard files and their contained identifiers."
        )

    @Argument(default: ".", help: "Path to scan for resources. If none is provided, the current directory will be used.")
    var path: String

    @Argument(help: "List of directory or file names to exclude.")
    var excluded: [String]

    func run() throws {
        let urlToScan = URL(fileURLWithPath: path, isDirectory: true, relativeTo: currentWorkingDirectoryURL)
        guard urlToScan.isFileURL else { throw Error.notFileURL(urlToScan) }

        // Everything is ready, scan the passed file URL
        try ResourceListGenerator().scanDirectory(at: urlToScan, excluding: excluded)
    }


    private let currentWorkingDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    enum Error: Swift.Error {
        case notFileURL(Foundation.URL)
    }
}
