// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVMKit",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MVVMKit",
            targets: ["MVVMKit"]),
    ],
    dependencies: [
        .package(name: "LocalizationKit", path: "../LocalizationKit"),
        .package(name: "ToolKit", path: "../ToolKit"),
        .package(name: "TrackingKit", path: "../TrackingKit")

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MVVMKit",
            dependencies: [
                .product(name: "LocalizationKit", package: "LocalizationKit"),
                .product(name: "ToolKit", package: "ToolKit"),
                .product(name: "TrackingKit", package: "TrackingKit")
            ]
        ),
        .testTarget(
            name: "MVVMKitTests",
            dependencies: ["MVVMKit"]),
    ]
)
