// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UICollectionViewLeftAlignedLayout",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UICollectionViewLeftAlignedLayout",
            targets: ["UICollectionViewLeftAlignedLayout"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UICollectionViewLeftAlignedLayout",
            dependencies: [],
            path: "UICollectionViewLeftAlignedLayout",
            exclude: ["Info.plist"],
            publicHeadersPath: "include"
        )
    ]
)
