// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("NonisolatedNonsendingByDefault")
]

let package = Package(
    name: "SubprocessDependenciesExample",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(
            name: "sd-example",
            targets: ["SubprocessDependencies"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.5.0"
        ),
        .package(
            url: "https://github.com/swiftlang/swift-subprocess.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies.git",
            from: "1.9.2"
        )
    ],
    targets: [
        .executableTarget(
            name: "SubprocessDependencies",
            dependencies: ["Commands"],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "Commands",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Subprocess", package: "swift-subprocess"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "CommandsTests",
            dependencies: [
                "Commands",
                .product(name: "DependenciesTestSupport", package: "swift-dependencies")
            ],
            swiftSettings: swiftSettings
        ),

    ]
)
