//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation
import SwiftCLI

private let verboseFlag = Flag("-v", "--verbose", description: "Verbose output")

extension Command {
    var verbose: Flag {
        return verboseFlag
    }
}

let cli = CLI(name: "resourceror", version: "1.0", description: "Resourceror - generate Swift names for your Xcode project resources", commands: [GenerateCommand()])
cli.globalOptions.append(verboseFlag)
cli.goAndExit()
