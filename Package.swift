// swift-tools-version:5.2

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
