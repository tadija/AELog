// swift-tools-version:5.5

/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2022 Marko Tadić
 *  Licensed under the MIT license
 */

import PackageDescription

let package = Package(
    name: "AELog",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_10),
        .tvOS(.v12),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "AELog",
            targets: ["AELog"]
        )
    ],
    targets: [
        .target(
            name: "AELog"
        ),
        .testTarget(
            name: "AELogTests",
            dependencies: ["AELog"]
        )
    ]
)
