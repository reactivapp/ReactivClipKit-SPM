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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-2.3.2610071.xcframework.zip",
            checksum: "031cb8368a27eb99640aba51a274bc2e1cd719dc67c17c23f4a70b7089059a0e"
        )
    ]
) 