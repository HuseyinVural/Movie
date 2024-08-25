// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UiComponents",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UiComponents",
            targets: ["UiComponents"]),
    ],
    dependencies: [
        .package(name: "StyleKit", path: "../StyleKit"),
        .package(name: "LocalizationKit", path: "../LocalizationKit"),
        .package(name: "ToolKit", path: "../ToolKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UiComponents",
            dependencies: [
                .product(name: "StyleKit", package: "StyleKit"),
                .product(name: "LocalizationKit", package: "LocalizationKit"),
                .product(name: "ToolKit", package: "ToolKit")
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "UiComponentsTests",
            dependencies: ["UiComponents"]),
    ]
)
