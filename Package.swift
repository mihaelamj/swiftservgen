// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftservgen",
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.32.0"),
    ],
    targets: [
        .executableTarget(
            name: "swiftservgen",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ]),
        .testTarget(
            name: "swiftservgenTests",
            dependencies: ["swiftservgen"],
            resources: [
                // Define any test resources.
                // .process("TestResources")
            ]
        ),
    ]
)
