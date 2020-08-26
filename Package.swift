// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChartsUILibrary",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ChartsUILibrary",
            targets: ["ChartsUILibrary"]),
        .library(
            name: "PieChart",
            targets: ["PieChart"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ChartsUILibrary",
            dependencies: []),
        .target(
            name: "PieChart",
            dependencies: []),
    ]
)
