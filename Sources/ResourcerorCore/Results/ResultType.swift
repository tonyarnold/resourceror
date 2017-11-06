//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import Foundation

enum ResultType: String, Hashable {

    case audio = "NSSound.Name"
    case image = "NSImage.Name"
    case nibName = "NSNib.Name"
    case storyboardName = "NSStoryboard.Name"

    case storyboardSceneIdentifier = "NSStoryboard.SceneIdentifier"
    case storyboardSegueIdentifier = "NSStoryboardSegue.Identifier"
    case userInterfaceItemIdentifier = "NSUserInterfaceItemIdentifier"

    case browserColumnsAutosaveName = "NSBrowser.ColumnsAutosaveName"
    case searchFieldRecentsAutosaveName = "NSSearchField.RecentsAutosaveName"
    case splitViewAutosaveName = "NSSplitView.AutosaveName"
    case tableViewAutosaveName = "NSTableView.AutosaveName"
    case windowFrameAutosaveName = "NSWindow.FrameAutosaveName"

    var hashValue: Int {
        return rawValue.hashValue
    }

    static func == (lhs: ResultType, rhs: ResultType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    func outputLine(for fileName: String) -> String {
        let name = variableName(using: fileName)
        return "static let \(name) = \(rawValue)(rawValue: \"\(fileName)\")"
    }

    private func variableName(using fileName: String) -> String {
        return fileName.camelCased()
    }
}
