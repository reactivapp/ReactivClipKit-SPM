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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-2.3.2604281.xcframework.zip",
            checksum: "41fc72982d01027d9de8288c3963072f9a7e5a5ffc801fd7c0b7c084f4daa752"
        )
    ]
) 