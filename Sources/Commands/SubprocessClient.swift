import Dependencies
import DependenciesMacros
import Subprocess

@DependencyClient
package struct SubprocessClient: Sendable {
    package var run: @Sendable (_ command: CommandEnvironment) async throws -> SubprocessResult
}

extension SubprocessClient: DependencyKey {
    package static let liveValue = Self(
        run: { command in
            let result = try await Subprocess.run(
                command.executable,
                arguments: command.arguments,
                input: .none,
                output: .string,
                error: .string
            )

            return SubprocessResult(
                isSuccess: result.terminationStatus.isSuccess,
                standardOutput: result.standardOutput,
                standardError: result.standardError
            )
        }
    )
}

package extension DependencyValues {
    var subprocessClient: SubprocessClient {
        get { self[SubprocessClient.self] }
        set { self[SubprocessClient.self] = newValue }
    }
}
