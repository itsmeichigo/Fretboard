// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fretboard",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Fretboard",
            targets: ["Fretboard"]),
    ],
    targets: [
        .target(
            name: "Fretboard",
            dependencies: []),
        .testTarget(
            name: "FretboardTests",
            dependencies: ["Fretboard"]),
    ]
)
