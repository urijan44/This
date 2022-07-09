// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThisDataLayer",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ThisDataLayer",
            targets: ["ThisDataLayer"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ThisDataLayer",
            dependencies: [],
            resources: [
              .process("Resources/token.plist"),
              .process("Resources/TMDBGenre.json")
            ]
        ),
        .testTarget(
          name: "ThisDataLayerTests",
          dependencies: ["ThisDataLayer"]
        )

    ]
)
