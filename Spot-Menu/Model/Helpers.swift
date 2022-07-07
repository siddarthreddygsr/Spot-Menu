import Cocoa
import Foundation

class Helpers {

    public static func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.launchPath = "/bin/zsh"
        task.standardInput = nil
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    public static func executeShellCommand(command: String, args: Array<String>) -> String {
        let pipe = Pipe()
        let process = Process()

        process.standardOutput = pipe
        process.launchPath = command
        process.arguments = args
        process.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let response: String = NSString(
            data: data,
            encoding: String.Encoding.utf8.rawValue
            )! as String
        return response
    }

    public static func excuteAppleScript(script: String) -> String {
        let response = executeShellCommand(
            command: "/usr/bin/osascript",
            args: ["-e", script]
            ).replacingOccurrences(of: "\n", with: "")
        return response
    }
}
