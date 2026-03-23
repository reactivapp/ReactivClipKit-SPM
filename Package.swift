// swift-tools-version:5.7
import PackageDescription

// Version: 1.3.2603231 (Major.Minor.DateBuild format)
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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.3.2603231.xcframework.zip",
            checksum: "6368bb7725cf37a1ae7d328c8bd548dc6065594298b6c1dc8e4c1f77aeb414cc"
        )
    ]
) 