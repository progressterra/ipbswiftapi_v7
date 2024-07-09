// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ipbswiftapi_v7",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        .library(
            name: "ipbswiftapi_v7",
            targets: ["ipbswiftapi_v7"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ipbswiftapi_v7",
            dependencies: []),
        .testTarget(
            name: "ipbswiftapi_v7Tests",
            dependencies: ["ipbswiftapi_v7"]),
    ]
)
