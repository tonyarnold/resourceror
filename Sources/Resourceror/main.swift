//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation
import SwiftCLI

CLI.setup(name: "resourceror", version: "1.0", description: "Resourceror - generate Swift names for your Xcode project resources")
CLI.register(command: GenerateCommand())
_ = CLI.go()
