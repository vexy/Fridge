// swift-tools-version:5.1
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
    platforms: [
        .macOS(.v10_10), .iOS(.v11), .tvOS(.v11),
    ],
    products: [
        .library( name: "Fridge", targets: ["Fridge"]),
    ],
    targets: [
        .target( name: "Fridge", dependencies: []),
        .testTarget( name: "FridgeTests", dependencies: ["Fridge"]),
    ]
)
