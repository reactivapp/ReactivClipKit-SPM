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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-2.3.2607271.xcframework.zip",
            checksum: "36e5d38d953fefd53dbcf955f7d3d0fd623179199ee425f77e54f6f1a0f78a4f"
        )
    ]
) 