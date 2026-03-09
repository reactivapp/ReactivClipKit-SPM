// swift-tools-version:5.7
import PackageDescription

// Version: 2.2.2602101 (Major.Minor.DateBuild format)
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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.3.2603093.xcframework.zip",
            checksum: "47ddea8fbfa1d3655b6daad6b60cbdd25c6224e5cc4ae01bd2b6d7ac838f7e90"
        )
    ]
) 