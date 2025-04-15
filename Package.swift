// swift-tools-version:5.3
import PackageDescription

// Version: 1.0.2504151 (Major.Minor.DateBuild format)
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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.0.2504151.xcframework.zip",
            checksum: "63b7e39121356b2b10d387925704028f86b1b15a877c56c90755482f6301ebe5"
        )
    ]
) 