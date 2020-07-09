// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HSHelpers",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "HSHelpers",
            targets: ["HSHelpers"]),
        .library(
            name: "HSAppKit",
            targets: ["HSAppKit"]),
        .library(
            name: "HSUIKit",
            targets: ["HSUIKit"]),
        .library(
            name: "HSSwiftUI",
            targets: ["HSSwiftUI"]),
        .library(
            name: "HSTime",
            targets: ["HSTime"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/dreymonde/Time.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HSHelpers",
            dependencies: []),
        .target(
            name: "HSAppKit",
            dependencies: ["HSHelpers"]),
        .target(
            name: "HSUIKit",
            dependencies: ["HSHelpers"]),
        .target(
            name: "HSSwiftUI",
            dependencies: ["HSHelpers"]),
        .target(
            name: "HSTime",
            dependencies: [.product(name: "Time", package: "Time")]),
        .testTarget(
            name: "HSHelpersTests",
            dependencies: ["HSHelpers"]),
    ]
)
