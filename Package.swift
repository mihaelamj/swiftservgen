// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftservgen",
    products: [
        .library(name: "ArgumentParser", targets: ["ArgumentParser"]),
        .library(name: "StuffGenerator", targets: ["StuffGenerator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.32.0"),
    ],
    targets: [
        .target(
            name: "ArgumentParser", 
            dependencies: []),
        
        .target(
            name: "StuffGenerator", 
            dependencies: []),
        
        .executableTarget(
            name: "swiftservgen",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                "ArgumentParser",
                "StuffGenerator"
            ]),
        
        .testTarget(
            name: "swiftservgenTests",
            dependencies: ["swiftservgen"],
            resources: [
                // Define any test resources.
                // .process("TestResources")
            ]
        ),
        
        .testTarget(
            name: "ArgumentParserTests",
            dependencies: ["ArgumentParser"]
        ),
        
        .testTarget(
            name: "StuffGeneratorTests",
            dependencies: ["StuffGenerator"]),
    ]
)
