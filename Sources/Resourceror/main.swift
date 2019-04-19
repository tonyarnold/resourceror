//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "Resourceror generates Swift names for your Xcode project resources")

program.version = "1.0.0"
program.register(command: GenerateCommand.self)
program.run()
