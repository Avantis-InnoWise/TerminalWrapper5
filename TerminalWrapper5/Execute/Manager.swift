import Foundation

final class Manager {
    let termCommnd = TerminalCommand()
    /* Method for safe command processing. Using the Process class, your program can run another program as a subprocess and can monitor that program’s execution. */
    
    /* Creating a Process object is a separate executable object, it differs from Tthread in that it does not share memory space with the process that creates it. */
    let process = Process()
    /* Pipe objects provide an object-oriented interface for accessing pipes.
     An Pipe object represents both ends of a pipe and enables communication through the pipe. */
    let pipe = Pipe()
    
    func start(_ message: String, type: Choose) throws -> String {
        process.standardOutput = pipe
        process.standardError = pipe
        /* - c flag - Use Cscore processing of the scorefile
         The NSTask object converts both path and the strings in arguments to appropriate C-style strings (using fileSystemRepresentation) before passing them to the task via argv[] .
         The strings in arguments do not undergo shell expansion, so you do not need to do special quoting, and shell variables, such as $PWD, are not resolved.
         Specifies the command arguments to be used to run the executable file. */
        let extStr = termCommnd.endTransformation(usingKey: Dimensions.encKey)
        process.arguments = [extStr, message]
        if #available(macOS 10.13, *) {
            process.executableURL = URL(fileURLWithPath: type.rawValue)
        } else {
            process.launchPath = type.rawValue
        }
        return try startMethod()
    }
    
    /* Function to run shell/bash command. */
    private func startMethod() throws -> String {
        do {
            /* chech macOS version and run command */
            if #available(macOS 10.13, *) {
                try process.run()
            } else {
                process.launch()
            }
        } catch {
            throw error // handle error
        }
        /* The object is automatically released when the recipient is released, and the handle itself represented by this object is deleted. */
        let dt = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: dt,
                                  encoding: .utf8) else { return "failed to execute command" } // manage command execution error
        return output // process final command data
    }
}

