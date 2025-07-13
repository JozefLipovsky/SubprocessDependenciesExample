import ArgumentParser
import Commands

@main
struct SubprocessDependencies: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "cmd-tool-example",
        subcommands: [
            MyCommand.self
        ]
    )
}
