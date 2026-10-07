// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_notifyvisitors",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // 1. Core plugin (Main app)
        .library(name: "flutter-notifyvisitors", targets: ["flutter_notifyvisitors"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tagnpin/nvecta-ios-sdk.git",
            exact: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "flutter_notifyvisitors",
            dependencies: [
                 // Link the specific products exposed by your native SPM package
                .product(name: "notifyvisitors", package: "nvecta-ios-sdk"),
                .product(name: "notifyvisitorsNudges", package: "nvecta-ios-sdk")
            ],
           publicHeadersPath: "include"
        )
    ]
)