// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xClient",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "xClient",
//            type: .dynamic,
            targets: ["xClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "XCGLogger", url: "https://github.com/DaveWoodCom/XCGLogger.git", from: "7.0.1"),
        .package(name: "SwiftyUserDefaults", url: "https://github.com/sunshinejr/SwiftyUserDefaults.git", from: "5.1.0"),
        .package(name: "xLib6000", url: "https://github.com/K3TZR/xLib6000.git", from: "1.7.1"),
        .package(name: "JWTDecode", url: "https://github.com/auth0/JWTDecode.swift.git", from: "2.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "xClient",
            dependencies: [
                "XCGLogger",
                "xLib6000",
                "SwiftyUserDefaults",
                "JWTDecode",
            ]),
        .testTarget(
            name: "xClientTests",
            dependencies: ["xClient"]),
    ]
)
