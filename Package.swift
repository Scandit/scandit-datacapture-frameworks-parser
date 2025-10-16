// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "scandit-datacapture-frameworks-parser",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ScanditFrameworksParser",
            targets: ["ScanditFrameworksParser"]
        ),
    ],
    dependencies: [
        .package(path: "../scandit-datacapture-frameworks-core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ScanditFrameworksParser",
            dependencies: [
                .product(name: "ScanditFrameworksCore", package: "scandit-datacapture-frameworks-core"),
                "ScanditParser"
            ]
        ),
        .binaryTarget(
            name: "ScanditParser",
            path: "Frameworks/ScanditParser.xcframework"
        ),
    ]
)
