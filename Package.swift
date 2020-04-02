// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "Resourceror",
  platforms: [
    .macOS(.v10_13)
  ],
  products: [
    .executable(name: "resourceror", targets: ["Resourceror"]),
    .library(name: "ResourcerorCore", targets: ["ResourcerorCore"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
    .package(url: "https://github.com/johnsundell/Files.git", from: "4.1.1"),
    .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.1")
  ],
  targets: [
    .target(
      name: "Resourceror",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .target(name: "ResourcerorCore")
      ]
    ),
    .target(
      name: "ResourcerorCore",
      dependencies: [
        .product(name: "Files", package: "Files"),
        .product(name: "Regex", package: "Regex")
      ]
    ),
    .testTarget(name: "ResourcerorCoreTests", dependencies: [
      .target(name: "ResourcerorCore")
    ])
  ],
  swiftLanguageVersions: [.v5]
)
