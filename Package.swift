// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChartsUILibrary",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ChartsUILibrary",
            targets: ["ChartsUILibrary"]),
        .library(
            name: "PieChart",
            targets: ["PieChart"]),
        .library(
            name: "BarChart",
            targets: ["BarChart"]),
        .library(
            name: "RingChart",
            targets: ["RingChart"]),
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
        .target(
            name: "BarChart",
            dependencies: []),
        .target(
            name: "RingChart",
            dependencies: []),
    ]
)
