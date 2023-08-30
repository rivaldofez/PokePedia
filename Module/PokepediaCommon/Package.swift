// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokepediaCommon",
    defaultLocalization: "en",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PokepediaCommon",
            targets: ["PokepediaCommon"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PokepediaCommon",
            dependencies: [],
            resources: [
                .process("Font/Comfortaa"),
                .process("Font/Poppins")
            ]
        ),
        .testTarget(
            name: "PokepediaCommonTests",
            dependencies: ["PokepediaCommon"]),
    ]
)
