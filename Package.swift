// swift-tools-version:5.0

/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AELog",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .tvOS(.v9),
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
