// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "serla-handy-paper-holder",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/tomasf/Cadova.git", .upToNextMinor(from: "0.1.0")),
    ],
    targets: [
        .executableTarget(
            name: "serla-handy-paper-holder",
            dependencies: ["Cadova"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ]
)
