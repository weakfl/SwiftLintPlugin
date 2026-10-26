# SwiftLintPlugin

Swift Package Manager plugins for [SwiftLint](https://github.com/realm/SwiftLint), using the prebuilt SwiftLint binary.

## Why this plugin

- **Fast builds**: SwiftLint ships as a prebuilt binary, so neither SwiftLint nor SwiftSyntax gets compiled from source.
- **One config for the whole project**: the build tool plugin lints the entire directory with the `.swiftlint.yml` at its root — other targets, loose files and local packages that live inside it included. The official [SwiftLintPlugins](https://github.com/SimplyDanny/SwiftLintPlugins) only lint the files of the target the plugin is attached to, and only look for configs within that target's package.
- **Always current**: a [daily workflow](.github/workflows/update.yml) picks up new SwiftLint releases. Each version is tagged `vX.Y.Z` and matches the [SwiftLint release](https://github.com/realm/SwiftLint/releases) of the same number.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/weakfl/SwiftLintPlugin", from: "0.65.1"),
]
```

## Configuration

The build tool plugin reads a `.swiftlint.yml` file:

| Context       | Config lookup                                  |
| ------------- | ---------------------------------------------- |
| Swift package | package root and/or the target's directory     |
| Xcode project | project root                                   |

The build fails if no config is found. If both the package root and the target directory contain one, SwiftLint runs once per config. Use `excluded` in the config to skip directories you don't want linted.

## Build tool plugin: `SwiftLintPlugin`

Lints before each build. Violations show up as build warnings and errors.

### Swift package

```swift
.target(
    name: "MyLibrary",
    plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLintPlugin")]
)
```

This lints the whole package directory, so attaching the plugin to one target is enough. Each additional target lints the directory again, though the cache keeps repeat runs cheap.

### Xcode project

Add `SwiftLintPlugin` under the target's *Build Phases → Run Build Tool Plug-ins*.

## Command plugin: `SwiftLint`

Lints on demand, without building — useful for autocorrecting and in CI.

### Swift package

```bash
swift package --allow-writing-to-package-directory swiftlint
swift package --allow-writing-to-package-directory swiftlint --fix
```

- Without `--target`, every target is linted. `--target MyLibrary` selects targets; pass it multiple times for more.
- Any other arguments go to SwiftLint, e.g. `--fix` or `--strict`.

### Xcode project

Right-click the project in the navigator and choose *SwiftLint*. The whole project directory is linted, and `--target` is ignored.
