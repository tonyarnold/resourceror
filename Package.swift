// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "Resourceror",
  platforms: [
    .macOS(.v10_13)
  ],
  products: [
    .executable(name: "resourceror", targets: ["resourceror"]),
    .library(name: "ResourcerorCore", targets: ["ResourcerorCore"])
  ],
  dependencies: [
    .package(url: "https://github.com/eneko/CommandRegistry", .upToNextMajor(from: "0.3.0")),
    .package(url: "https://github.com/apple/swift-package-manager.git", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/johnsundell/Files", .upToNextMajor(from: "2.2.1")),
    .package(url: "https://github.com/sharplet/Regex.git", .upToNextMajor(from: "2.0.0"))
  ],
  targets: [
    .target(
      name: "resourceror",
      dependencies: [
        "CommandRegistry",
        "ResourcerorCore",
        "Utility"
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
  swiftLanguageVersions: [.v5]
)
