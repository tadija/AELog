// swift-tools-version:5.3

/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import PackageDescription

let package = Package(
    name: "AELog",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
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
