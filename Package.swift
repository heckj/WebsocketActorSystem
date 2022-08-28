// swift-tools-version: 5.7

import PackageDescription

var globalSwiftSettings: [SwiftSetting] = []
var targets: [Target] = [
    .target(
        name: "WebsocketActorSystem",
        dependencies: [
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "NIOHTTP1", package: "swift-nio"),
            .product(name: "NIOWebSocket", package: "swift-nio"),
            .product(name: "NIOTransportServices", package: "swift-nio-transport-services"),
        ]
    ),
    .testTarget(
        name: "WebsocketActorSystemTests",
        dependencies: ["WebsocketActorSystem"]
    ),
]

let package = Package(
    name: "WebsocketActorSystem",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "WebsocketActorSystem",
            targets: ["WebsocketActorSystem"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.12.0"),
        .package(url: "https://github.com/apple/swift-nio-transport-services.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", branch: "main"),
    ],
    targets: targets.map { target in
        var swiftSettings = target.swiftSettings ?? []
        if target.type != .plugin {
            swiftSettings.append(contentsOf: globalSwiftSettings)
        }
        if !swiftSettings.isEmpty {
            target.swiftSettings = swiftSettings
        }
        return target
    }
)
