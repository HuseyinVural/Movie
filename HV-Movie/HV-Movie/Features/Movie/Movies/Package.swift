// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Movies",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Movies",
            targets: ["Movies"]),
    ],
    dependencies: [
        .package(name: "ToolKit", path: "../../Foundation/ToolKit"),
        .package(name: "Data", path: "../../Data"),
        .package(name: "StyleKit", path: "../../Foundation/StyleKit"),
        .package(name: "UiComponents", path: "../../Foundation/UiComponents"),

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Movies", dependencies: [
                .product(name: "ToolKit", package: "ToolKit"),
                .product(name: "Data", package: "Data"),
                .product(name: "StyleKit", package: "StyleKit"),
                .product(name: "UiComponents", package: "UiComponents")
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "MoviesTests",
            dependencies: ["Movies"]),
    ]
)
