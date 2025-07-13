import Foundation

package struct SubprocessResult {
    package let isSuccess: Bool
    package let standardOutput: String?
    package let standardError: String?

    package init(isSuccess: Bool, standardOutput: String?, standardError: String?) {
        self.isSuccess = isSuccess
        self.standardOutput = standardOutput
        self.standardError = standardError
    }
}
