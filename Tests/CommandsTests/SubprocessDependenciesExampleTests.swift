import Commands
import Dependencies
import DependenciesTestSupport
import Subprocess
import Testing

@Suite
struct SubprocessDependenciesExampleTests {
    
    @Test(.subprocessClientTrait())
    func myCommand_runs_capturesCommands() async throws {
        let sut = try MyCommand.parse([])
        try await sut.run()
        let commands = await SubprocessClientTrait.executedCommands()
        #expect(commands.count == 2, "Expected exactly two subprocess commands.")
        #expect(commands[0].executable == .name("swift"))
        #expect(commands[0].arguments == ["package", "tools-version", "--set", "6.0"])
        #expect(commands[1].executable == .name("swift"))
        #expect(commands[1].arguments == ["package", "add-target", "TestModule"])
    }
}
