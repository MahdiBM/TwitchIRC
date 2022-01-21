// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TwitchIRC",
    products: [
        .library(
            name: "TwitchIRC",
            targets: ["TwitchIRC"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TwitchIRC",
            dependencies: []),
        .testTarget(
            name: "TwitchIRCTests",
            dependencies: ["TwitchIRC"]),
    ]
)
