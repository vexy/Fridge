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
        .iOS(.v13),
        .watchOS(.v2),
        .macOS(.v10_15),
        .tvOS(.v9)
    ],
    
    // Product definitions
    products: [
        .library(name: "Fridge", targets: ["Fridge"]),
    ],
    dependencies: [],
    
    // Output target
    targets: [
        .target(
            name: "Fridge",
            dependencies: [],
            exclude: [
                "../../Docs",
                "../../README.md"
            ]
        ),
        .testTarget(name: "FridgeTests", dependencies: ["Fridge"]),
    ]
)
