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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.0.2504241.xcframework.zip",
            checksum: "3c1183a4bbc2e0bdc9a622a992f15dcbd52b29a085ddf9eab1b78b9432fbe886"
        )
    ]
) 