//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import CommandRegistry
import Foundation
import ResourcerorCore
import Utility

class GenerateCommand: Command {
  enum Error: Swift.Error { case notFileURL(Foundation.URL) }

  let command = "generate"
  let overview = "Generates a list of images, XIB and Storyboard files and their contained identifiers"

  let subparser: ArgumentParser
  var subcommands: [Command] = []

  let excludedPathNames: OptionArgument<[String]>
  let resourceDirectory: PositionalArgument<String>

  required init(parser: ArgumentParser) {
    self.subparser = parser.add(subparser: command, overview: overview)
    self.excludedPathNames = subparser.add(option: "--exclude", shortName: "-e", kind: [String,].self, usage: "List of directory or file names to exclude (optional)")
    self.resourceDirectory = subparser.add(positional: "paths", kind: String.self, optional: true, usage: "Path to scan for resources. If none is provided, the current directory will be used.")
  }

  func run(with arguments: ArgumentParser.Result) throws {
    // If no path has been passed on the command line, use the current working directory as the path to scan.
    let pathToScan = arguments.get(resourceDirectory) ?? "."
    let urlToScan = URL(fileURLWithPath: pathToScan, isDirectory: true, relativeTo: currentWorkingDirectoryURL)
    guard urlToScan.isFileURL else { throw Error.notFileURL(urlToScan) }

    // Split the list of excluded directory names into an array of names
    let excludedDirectories = arguments.get(excludedPathNames) ?? []

    // Everything is ready, scan the passed file URL
    try generator.scanDirectory(at: urlToScan, excluding: excludedDirectories)
  }

  private let generator = ResourceListGenerator()
  private let currentWorkingDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
}
