// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ConfigurationProvider",
    products: [
        .library(
            name: "ConfigurationProvider",
            targets: ["ConfigurationProvider"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ConfigurationProvider",
            path: "ConfigurationProvider/ConfigurationProvider"),
        .testTarget(
            name: "ConfigurationProviderTests",
            dependencies: ["ConfigurationProvider"],
            path: "ConfigurationProvider/ConfigurationProviderTests"),
    ]
)
