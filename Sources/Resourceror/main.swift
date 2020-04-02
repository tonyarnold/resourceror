//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import ArgumentParser

struct Resourceror: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Resourceror generates Swift names for your Xcode project resources.",
        subcommands: [Generate.self],
        defaultSubcommand: Generate.self
    )
}

Resourceror.main()
