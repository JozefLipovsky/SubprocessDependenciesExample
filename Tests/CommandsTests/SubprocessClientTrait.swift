import Commands
import Dependencies
import DependenciesTestSupport
import Testing

struct SubprocessClientTrait: TestTrait, TestScoping {
    @TaskLocal private static var commandsLog: CommandsLog?

    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: @Sendable () async throws -> Void
    ) async throws {
        let commandsLog = CommandsLog()

        try await Self.$commandsLog.withValue(commandsLog) {
            try await withDependencies {
                $0.subprocessClient.run = { command in
                    await commandsLog.append(command)

                    return SubprocessResult(
                        isSuccess: true,
                        standardOutput: "",
                        standardError: ""
                    )
                }
            } operation: {
                try await function()
            }
        }
    }

    public static func executedCommands() async -> [CommandEnvironment] {
        guard let commandsLog else {
            reportIssue("No commands log found")
            return []
        }

        return await commandsLog.commands
    }
}

extension SubprocessClientTrait {
    actor CommandsLog {
        private(set) var commands: [CommandEnvironment] = []
        func append(_ command: CommandEnvironment) { commands.append(command) }
    }
}

extension TestTrait where Self == SubprocessClientTrait {
    static func subprocessClientTrait() -> Self {
        .init()
    }
}
