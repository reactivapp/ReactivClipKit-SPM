// swift-tools-version:5.7
import PackageDescription

// Version: 1.0.2504212 (Major.Minor.DateBuild format)
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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.0.2504212.xcframework.zip",
            checksum: "100b586ed8eb752fcaf83ef86fefa4d548767c466e31b6ac6a07148f0505b38f"
        )
    ]
) 