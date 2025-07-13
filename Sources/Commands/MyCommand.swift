import ArgumentParser
import Dependencies
import Foundation

public struct MyCommand: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "my-command"
    )

    public init() {}

    public func run() async throws {
        @Dependency(\.subprocessClient) var subprocessClient

        let toolsVersionCommand = CommandEnvironment(
            executable: .name("swift"),
            arguments: ["package", "tools-version", "--set", "6.0"]
        )
        _ = try await subprocessClient.run(toolsVersionCommand)


        let addTargetCommand = CommandEnvironment(
            executable: .name("swift"),
            arguments: ["package", "add-target", "TestModule"]
        )

        _ = try await subprocessClient.run(addTargetCommand)
    }
}
