// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let productionFeatures: [PackageDescription.Target.Dependency] = [
    "HomeFeature",
    "ProfileFeature",
]

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
        
        // Apps layer
        .target(
            name: "DevelopApp",
            dependencies: productionFeatures,
            path: "./Sources/Apps/Develop"),
        .target(
            name: "ProductionApp",
            dependencies: productionFeatures,
            path: "./Sources/Apps/Production"),
        
        // Features layer
        .target(
            name: "HomeFeature",
            dependencies: ["RepoData"],
            path: "./Sources/Features/Home"),
        .target(
            name: "ProfileFeature",
            dependencies: ["UserData"],
            path: "./Sources/Features/Profile"),
        
        //Data layer
        .target(
            name: "UserData",
            dependencies: ["NetworkCore"],
            path: "./Sources/Data/User"),
        .target(
            name: "RepoData",
            dependencies: ["NetworkCore"],
            path: "./Sources/Data/Repo"),
        
        //Core layer
        .target(
            name: "NetworkCore",
            dependencies: [],
            path: "./Sources/Core/Network"),
        .target(
            name: "UICore",
            dependencies: [],
            path: "./Sources/Core/UI"),
    ]
)
