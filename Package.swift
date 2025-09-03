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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.1.2509021.xcframework.zip",
            checksum: "faa28c2ce36c2b72b21c40ebb70d69db92074b18c7e52d0491774ec52d35b6aa"
        )
    ]
) 