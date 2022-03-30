/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import Foundation

// MARK: - API / Main

/// Writes textual representation of input parameters into the standard debugger / device output.
///
/// - Note: `Log.Mode.print` is default, if logging is not enabled in settings it will do nothing.
/// - Warning: `Log.Mode.nsLog` will work wether logging is enabled in settings or not.
///
/// - Parameters:
///   - items: Variadic parameter (zero or more values of a `Any` type).
///   - mode: `Log.Mode` (defaults to `.print`).
///   - path: Calling file path (defaults to `#file`).
///   - lineNumber: Calling line number (defaults to `#line`).
///   - function: Calling function (defaults to `#function`).
public func aelog(_ items: Any...,
                  mode: Log.Mode = .print,
                  path: String = #file,
                  lineNumber: Int = #line,
                  function: String = #function) {
    Log.shared.write(
        mode: mode,
        thread: Thread.current,
        path: path,
        lineNumber: lineNumber,
        function: function,
        text: text(with: items)
    )
}

private func text(with items: Any...) -> String {
    let array = items.first as? [Any] ?? items as [Any]
    switch array.count {
    case 0:
        return String()
    case 1:
        return "\(array.first.unsafelyUnwrapped)"
    default:
        var text = "\n\n"
        for (index, element) in array.enumerated() {
            let type = Mirror(reflecting: element).subjectType
            let description = String(reflecting: element)
            text += "#\(index): \(type) | \(description)\n"
        }
        return text
    }
}

// MARK: - LogDelegate

public protocol LogDelegate: AnyObject {
    /// Forwards the latest log line.
    /// This method is called from logging queue, dispatch to main queue if needed.
    ///
    /// - Parameters:
    ///   - line: logged line
    ///   - mode: log mode
    func didLog(line: Line, mode: Log.Mode)
}

// MARK: - Log

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
    /// `Mode.print` works only if logging is enabled & specific file not disabled in `settings`.
    /// `Mode.nsLog` will always work irrespective of other settings.
    ///
    /// - Parameters:
    ///   - mode: Logging mode
    ///   - thread: Calling thread
    ///   - path: Calling path
    ///   - lineNumber: Calling line number
    ///   - function: Calling function
    ///   - text: Custom text
    public func write(mode: Mode,
                      thread: Thread,
                      path: String,
                      lineNumber: Int,
                      function: String,
                      text: String) {
        queue.async { [unowned self] in
            guard self.settings.isEnabled || mode == .nsLog else {
                return
            }
            let name = self.getFileName(for: path)
            if self.isLogEnabledForFile(with: name) || mode == .nsLog {
                let line = Line(
                    thread: thread,
                    file: name,
                    number: lineNumber,
                    function: function,
                    text: text
                )
                self.log(line: line, mode: mode)
            }
        }
    }
    
    // MARK: Helpers
    
    private func getFileName(for path: String) -> String {
        guard let fileName = NSURL(fileURLWithPath: path)
            .deletingPathExtension?.lastPathComponent else {
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
        delegate?.didLog(line: line, mode: mode)
    }
    
}
