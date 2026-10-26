import Foundation
import PackagePlugin

extension CommandPlugin {
    func lintCode(in directory: PackagePlugin.Path, context: PluginToolProviding, arguments: [String]) throws {
        let tool = try context.tool(named: "swiftlint")
        let toolURL = URL(fileURLWithPath: tool.path.string)

        var processArguments = [directory.string, "--cache-path", context.pluginWorkDirectory.string]
        processArguments.append(contentsOf: arguments)

        let process = Process()
        process.executableURL = toolURL
        process.arguments = processArguments

        try process.run()
        process.waitUntilExit()

        if process.terminationReason == .exit, process.terminationStatus == 0 {
            print("Linted the source code in \(directory.string).")
        } else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("swiftlint invocation failed: \(problem)")
        }
    }
}
