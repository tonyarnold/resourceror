//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import Regex

final class StoryboardScanner: ResourceScanning {

    static let fileExtensions = ["storyboard"]

    static let ignoredTags = [
        "deployment",
        "plugIn"
    ]

    var filesToScan = [File]()

    func scan(file: File) -> Set<ScanResult> {
        // Open Storyboard, and scan for:
        guard let fileContents = try? file.readAsString() else {
            return []
        }

        var results = Set<ScanResult>()

        let fileResult = ScanResult(type: .storyboardName, identifier: file.nameExcludingExtension)
        results.insert(fileResult)

        type(of: self).storyboardIdentifierRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .storyboardSceneIdentifier, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).identifierRegex.allMatches(in: fileContents).forEach { match in
            guard
                let tagName = match.captures[0],
                let identifier = match.captures[1],
                StoryboardScanner.ignoredTags.contains(tagName) == false
            else {
                return
            }

            let resultType: ResultType = tagName == "segue" ? .storyboardSegueIdentifier : .userInterfaceItemIdentifier
            let newResult = ScanResult(type: resultType, identifier: identifier)
            results.insert(newResult)
        }

        return results
    }

    private static let deploymentIdentifierRegex = Regex("<deployment identifier=\"([A-Za-z0-9]+)\"/>", options: .anchorsMatchLines)
    private static let identifierRegex = Regex("<([A-Za-z0-9]+).* identifier=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let storyboardIdentifierRegex = Regex("<[windowController|viewController].* storyboardIdentifier=\"([^\"]+)\".*$", options: .anchorsMatchLines)
}
