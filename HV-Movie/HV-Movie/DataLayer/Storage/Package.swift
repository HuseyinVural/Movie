// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Storage",
            targets: ["Storage"]),
        .library(
            name: "StorageInterface",
            targets: ["StorageInterface"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Storage", dependencies: ["StorageInterface"]),
        .testTarget(
            name: "StorageTests",
            dependencies: ["Storage", "StorageInterface"]),
        .target(
            name: "StorageInterface"),
    ]
)
