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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.1.2509301.xcframework.zip",
            checksum: "ec7ee9d81f4b74b63729ba82992f75dfdb714af756c0be41577cc8a60f81cbaa"
        )
    ]
) 