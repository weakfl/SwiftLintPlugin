import Foundation
import PackagePlugin

protocol PluginToolProviding {
    func tool(named name: String) throws -> PackagePlugin.PluginContext.Tool
}

extension PluginContext: PluginToolProviding {}
