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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.3.2603171.xcframework.zip",
            checksum: "a927c2b9ae2a422c5daaa3a444f45b45c13e2f6b1c27b5d94b7146f19dc5c9b2"
        )
    ]
) 