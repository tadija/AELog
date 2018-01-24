/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public protocol LogDelegate: class {
    /// Forwards the latest log line.
    /// This method is called from logging queue, dispatch to main queue if needed.
    ///
    /// - Parameters:
    ///   - line: logged line
    ///   - mode: log mode
    func didLog(line: Line, mode: Log.Mode)
}

/// Handles logging from top level functions
open class Log {

    /// Logging Mode
    ///
    /// - print: Writes to debugger console only.
    /// - nsLog: Writes to both debugger and device console.
    public enum Mode {
        case print
        case nsLog
    }

    // MARK: Properties

    /// Singleton
    public static let shared = Log()

    /// Log Delegate
    public weak var delegate: LogDelegate?

    /// Log Settings
    public let settings = Settings()

    private let queue = DispatchQueue(label: "AELog")
    
    // MARK: API

    /// Performs printing to standard output based on input parameters.
    ///
    /// `Mode.print` will work only if logging is enabled and specific file is not disabled in `settings`.
    /// `Mode.nsLog` will always work irrespective of other settings.
    ///
    /// - Parameters:
    ///   - mode: Logging mode
    ///   - thread: Calling thread
    ///   - path: Calling path
    ///   - lineNumber: Calling line number
    ///   - function: Calling function
    ///   - text: Custom text
    public func write(mode: Mode, thread: Thread, path: String, lineNumber: Int, function: String, text: String) {
        queue.async { [unowned self] in
            guard self.settings.isEnabled || mode == .nsLog else {
                return
            }
            let name = self.getFileName(for: path)
            if self.isLogEnabledForFile(with: name) || mode == .nsLog {
                let line = Line(thread: thread, file: name, number: lineNumber, function: function, text: text)
                self.log(line: line, mode: mode)
            }
        }
    }
    
    // MARK: Helpers
    
    private func getFileName(for path: String) -> String {
        guard let fileName = NSURL(fileURLWithPath: path).deletingPathExtension?.lastPathComponent else {
            return "Unknown"
        }
        return fileName
    }
    
    private func isLogEnabledForFile(with fileName: String) -> Bool {
        guard let fileEnabled = settings.files[fileName] else {
            return true
        }
        return fileEnabled
    }

    private func log(line: Line, mode: Mode) {
        switch mode {
        case .print:
            print(line.description)
        case .nsLog:
            NSLog(line.descriptionWithoutTimestamp)
        }
        self.delegate?.didLog(line: line, mode: mode)
    }
    
}
