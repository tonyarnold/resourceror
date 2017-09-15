//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import SwiftCLI

struct GlobalOptions: GlobalOptionsSource {
    static let verbose = Flag("-v", "--verbose", usage: "Verbose output")
    static var options: [Option] = [verbose]
}

extension Command {
    var verbose: Flag {
        return GlobalOptions.verbose
    }
}
