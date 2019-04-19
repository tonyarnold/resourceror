# Resourceror

This tool will generate static variables as extensions to the common AppKit types that accepted typed names, i.e.:

```swift
// Resourceror outputs the following, which you can add to your project:
extension NSImage {
    static let backgroundImage = NSImage(named: "background-image")
}

// Which means you can now do the following:
let backgroundImage = NSImage.backgroundImage
```

Neato!

Resourceror currently supports extensions on `NSImage`, `NSNib`, `NSStoryboard`, `NSStoryboard.SceneIdentifier`, `NSStoryboardSegue.Identifier` and `NSUserInterfaceItemIdentifier`. Feel free to submit PRs for anything else you'd like to see generated.

It's not quite finished, but you should be able to use it. The project lacks tests, the code is not polished, and everything needs a bit of work - it meets my needs, and it might be useful to you.

## Usage

Basically, you run this command against a directory containing your images, XIBs, and Storyboards, and it will print a nicely sorted list of properly typed Swift static variables for your resources.

```sh
swift run resourceror generate $PATH_TO_YOUR_DIRECTORY --exclude first_directory second_directory
```

## Requirements

- macOS 10.13 or newer
- Xcode 10.2 / Swift 5.0 or newer

## Notes

If you use SwiftLint, you'll probably need to surround the output code with commands to disable some checks, like so:

```swift
// swiftlint:disable file_length
// swiftlint:disable force_unwrap
// swiftlint:disable identifier_name

extension NSImage {
    // …
}

extension NSNib {
    // …
}

extension NSStoryboard {
    // …
}

extension NSStoryboard.SceneIdentifier {
    // …
}

extension NSStoryboardSegue.Identifier {
    // …
}

extension NSUserInterfaceItemIdentifier {
    // …
}
```
