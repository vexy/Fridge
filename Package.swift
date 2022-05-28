// swift-tools-version:5.5
/*
 * RECREATED BY VEXY @ Januarry 16, 2020 9:50pm
 * Package.swift
 *
 * MIT License
 * Copyright (c) 2016 Veljko Tekelerović
*/

import PackageDescription

let package = Package(
    name: "Fridge",
    
    // Supported platforms
    platforms: [
        .iOS(.v11),
        .macOS(.v10_14),
        .tvOS(.v11)
    ],
    
    // Product definitions
    products: [
        .library(name: "Fridge", targets: ["Fridge"]),
    ],
    dependencies: [
        .package(name: "BSONCoder", url: "https://github.com/vexy/bsoncoder", branch: "main")
    ],
    
    // Output target
    targets: [
        .target(
            name: "Fridge",
            dependencies: [
                .product(name: "bsoncoder", package: "BSONCoder")
            ],
            exclude: [
                "../../Guides",
                "../../README.md"
            ]
        ),
        .testTarget(name: "FridgeTests", dependencies: ["Fridge"]),
    ]
)
