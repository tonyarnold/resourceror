//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation

extension String {

    func pascalCased(followingCharacters characterSet: CharacterSet = CharacterSet.alphanumerics.inverted) -> String {
        return components(separatedBy: characterSet).map { $0.uppercasedFirstCharacter() }.joined(separator: "")
    }

    func camelCased(followingCharacters characterSet: CharacterSet = CharacterSet.alphanumerics.inverted) -> String {
        return pascalCased(followingCharacters: characterSet).lowercasedFirstCharacter()
    }

    func lowercasedFirstCharacter() -> String {
        guard isEmpty == false else { return self }
        guard count > 1 else { return self.uppercased() }

        let firstIndex = index(startIndex, offsetBy: 1)
        return self[..<firstIndex].lowercased() + self[firstIndex...]
    }

    func uppercasedFirstCharacter() -> String {
        guard isEmpty == false else { return self }
        guard count > 1 else { return self.uppercased() }

        let firstIndex = index(startIndex, offsetBy: 1)
        return self[..<firstIndex].uppercased() + self[firstIndex...]
    }
}
