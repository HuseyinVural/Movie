// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(name: "Network", path: "../Network"),
        .package(name: "Storage", path: "../Storage"),
        .package(name: "ToolKit", path: "../../Foundation/ToolKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Data",
            dependencies: [
                .product(name: "NetworkInterface", package: "Network"),
                .product(name: "StorageInterface", package: "Storage"),
                .product(name: "ToolKit", package: "ToolKit")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"])
    ]
)
