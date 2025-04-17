// swift-tools-version:5.7
import PackageDescription

// Version: 1.0.2504161 (Major.Minor.DateBuild format)
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
            url: "https://cdn.reactivapp.com/downloads/reactiv-clip-kit/ReactivClipKit-1.0.2504161.xcframework.zip",
            checksum: "01874d332ca1918932c89243100b9f63c742d0b9f1fb1ee005590d39b63f2239"
        )
    ]
) 