// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwiftLintPlugin",
    products: [
        .plugin(name: "SwiftLint", targets: ["SwiftLint"]),
        .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"])
    ],
    dependencies: [],
    targets: [
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .plugin(
            name: "SwiftLint",
            capability: .command(
                intent: .custom(
                    verb: "swiftlint",
                    description: "Lints source code"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "This command lints source files"),
                ]
            ),
            dependencies: [.target(name: "SwiftLintBinary")]
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.52.3/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "05cbe202aae733ce395de68557614b0dfea394093d5ee53f57436e4d71bbe12f"
        )
    ]
)
