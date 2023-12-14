// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "github-app",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Develop", targets: ["DevelopApp"]),
        .library(name: "Production", targets: ["ProductionApp"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DevelopApp",
            path: "./Sources/Apps/Develop"),
        .target(
            name: "ProductionApp",
            path: "./Sources/Apps/Production"),
    ]
)
