// swift-tools-version:5.7
import PackageDescription

// Version: 1.0.2504231 (Major.Minor.DateBuild format)
let package = Package(
    name: "ReactivClipKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReactivClipKit",
            targets: ["ReactivClipKit"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "ReactivClipKit",
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-2.2.2602062.xcframework.zip",
            checksum: "ab3a9aa60df65069805701083bbde1a0b3a4acd394cd3a8da084038f8c544790"
        )
    ]
) 