import Foundation
import Subprocess

package struct CommandEnvironment: Equatable {
    package let executable: Executable
    package let arguments: Arguments

    package init(executable: Executable, arguments: Arguments) {
        self.executable = executable
        self.arguments = arguments
    }
}
