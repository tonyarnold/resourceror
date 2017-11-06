//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Files
import Foundation
import Regex

final class InterfaceBuilderDocumentScanner: ResourceScanning {

    static let fileExtensions = ["xib"]

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

        let fileResult = ScanResult(type: .nibName, identifier: file.nameExcludingExtension)
        results.insert(fileResult)

        type(of: self).identifierRegex.allMatches(in: fileContents).forEach { match in
            guard
                let tagName = match.captures[0],
                let identifier = match.captures[1],
                InterfaceBuilderDocumentScanner.ignoredTags.contains(tagName) == false
            else {
                return
            }

            let resultType: ResultType = tagName == "segue" ? .storyboardSegueIdentifier : .userInterfaceItemIdentifier
            let newResult = ScanResult(type: resultType, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).browserViewAutosaveNameRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .browserColumnsAutosaveName, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).searchFieldAutosaveNameRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .searchFieldRecentsAutosaveName, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).splitViewAutosaveNameRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .splitViewAutosaveName, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).tableViewAutosaveNameRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .tableViewAutosaveName, identifier: identifier)
            results.insert(newResult)
        }

        type(of: self).windowFrameAutosaveNameRegex.allMatches(in: fileContents).forEach { match in
            guard let identifier = match.captures[0] else { return }

            let newResult = ScanResult(type: .windowFrameAutosaveName, identifier: identifier)
            results.insert(newResult)
        }

        return results
    }

    private static let deploymentIdentifierRegex = Regex("<deployment identifier=\"([A-Za-z0-9]+)\"/>", options: .anchorsMatchLines)
    private static let identifierRegex = Regex("<([A-Za-z0-9]+).* identifier=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let browserViewAutosaveNameRegex = Regex("<browser.* columnsAutosaveName=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let searchFieldAutosaveNameRegex = Regex("<searchField.* recentsAutosaveName=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let splitViewAutosaveNameRegex = Regex("<splitView.* autosaveName=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let tableViewAutosaveNameRegex = Regex("<tableView.* autosaveName=\"([^\"]+)\".*$", options: .anchorsMatchLines)
    private static let windowFrameAutosaveNameRegex = Regex("<window.* frameAutosaveName=\"([^\"]+)\".*$", options: .anchorsMatchLines)
}
