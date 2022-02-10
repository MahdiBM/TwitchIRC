// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "TwitchIRC",
    products: [
        .library(
            name: "TwitchIRC",
            targets: ["TwitchIRC"]),
    ],
    targets: [
        .target(name: "TwitchIRC"),
        .testTarget(
            name: "TwitchIRCTests",
            dependencies: ["TwitchIRC"]),
    ]
)
