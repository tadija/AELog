// swift-tools-version:4.0

/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AELog",
    products: [
        .library(name: "AELog", targets: ["AELog"])
    ],
    targets: [
        .target(
            name: "AELog",
            path: "Sources"
        ),
        .testTarget(
            name: "AELogTests",
            dependencies: ["AELog"]
        )
    ]
)
