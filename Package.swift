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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.2.2509301.xcframework.zip",
            checksum: "b2e2f15bc3100b0da32e3c0c514e3e4a2efa1bb94a9f70ddec0c8c6ad80dcbe3"
        )
    ]
) 