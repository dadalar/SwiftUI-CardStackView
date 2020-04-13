// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CardStack",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "CardStack", targets: ["CardStack"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.7.2")
    ],
    targets: [
        .target(name: "CardStack", dependencies: []),
        .testTarget(name: "CardStackTests", dependencies: ["CardStack", "SnapshotTesting"])
    ]
)
