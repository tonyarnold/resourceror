//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation

struct ScanResult: Hashable {
    let type: ResultType
    let identifier: String

    var outputLine: String {
        return type.outputLine(for: identifier)
    }

    var hashValue: Int {
        return type.hashValue &+ identifier.hashValue
    }

    static func == (lhs: ScanResult, rhs: ScanResult) -> Bool {
        return lhs.type == rhs.type && lhs.identifier == rhs.identifier
    }
}
