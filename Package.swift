// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Resourceror",
    products: [
        .executable(name: "rsrcrr", targets: ["Resourceror"]),
        .library(name: "ResourcerorCore", targets: ["ResourcerorCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/Files", .upToNextMajor(from: "1.10.0")),
        .package(url: "https://github.com/jakeheis/SwiftCLI", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/sharplet/Regex", .upToNextMajor(from: "1.1.0"))
    ],
    targets: [
        .target(
            name: "Resourceror",
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
