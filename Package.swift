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
            url: "https://github.com/realm/SwiftLint/releases/download/0.57.1/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "c88bf3e5bc1326d8ca66bc3f9eae786f2094c5172cd70b26b5f07686bb883899"
        )
    ]
)
