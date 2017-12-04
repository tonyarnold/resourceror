// swift-tools-version:4.0

//
//  Copyright © 2017 Tony Arnold (@tonyarnold)
//  Licensed under the MIT license. See the LICENSE file for details.

import PackageDescription

let package = Package(
    name: "Resourceror",
    products: [
        .executable(name: "resourceror", targets: ["resourceror"]),
        .library(name: "ResourcerorCore", targets: ["ResourcerorCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/Files", .upToNextMajor(from: "2.0.1")),
        .package(url: "https://github.com/jakeheis/SwiftCLI", .upToNextMajor(from: "4.0.3")),
        .package(url: "https://github.com/sharplet/Regex", .upToNextMajor(from: "1.1.0"))
    ],
    targets: [
        .target(
            name: "resourceror",
            dependencies: [
                "SwiftCLI",
                "ResourcerorCore"
            ]
        ),
        .target(
            name: "ResourcerorCore",
            dependencies: [
                "Files",
                "Regex"
            ]
        )
    ],
    swiftLanguageVersions: [4]
)
