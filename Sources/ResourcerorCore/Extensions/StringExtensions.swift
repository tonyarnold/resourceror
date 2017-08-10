//
//  The MIT License (MIT)
//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

extension String {
    func replacingCharacters(in characterSet: CharacterSet, with separator: String) -> String {
        return components(separatedBy: characterSet).joined(separator: separator)
    }

    func camelCaseCharactersFollowing(in characterSet: CharacterSet, with separator: String) -> String {
        return components(separatedBy: characterSet).map { $0.uppercasedFirstCharacter() }.joined(separator: separator)
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

