/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - API / Main

public func aelog(_ items: Any..., mode: Log.Mode = .print,
                  path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.write(mode: mode,
                     thread: Thread.current,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     text: text(with: items))
}

private func text(with items: Any...) -> String {
    let array = items.first.unsafelyUnwrapped as! [Any]
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

/// Writes the textual representation of input parameters into the standard debugger output.
///
/// - Note: This method is using `print` internally, but if logging is not enabled in settings it will do nothing.
///
/// - Parameters:
///   - text: Custom text (defaults to empty string).
///   - path: Calling file path (defaults to `#file`).
///   - lineNumber: Calling line number (defaults to `#line`).
///   - function: Calling function (defaults to `#function`).
public func logToDebugger(_ text: String = "",
                          path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.write(mode: .print,
                     thread: Thread.current,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     text: text)
}

/// Writes the textual representation of input parameters into both debugger and device standard output.
///
/// - Warning: This method is using `NSLog` internally, and it will work wether logging is enabled in settings or not.
///
/// - Parameters:
///   - text: Custom text (defaults to empty string).
///   - path: Calling file path (defaults to `#file`).
///   - lineNumber: Calling line number (defaults to `#line`).
///   - function: Calling function (defaults to `#function`).
public func logToDevice(_ text: String = "",
                        path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.write(mode: .nsLog,
                     thread: Thread.current,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     text: text)
}

// MARK: - API / Convenience

/// Writes the textual representation of input parameters suitable for debugging into the standard debugger output.
///
/// - Note: This method is using `print` internally, but if logging is not enabled in settings it will do nothing.
///
/// - Parameters:
///   - text: Custom text (defaults to empty string).
///   - path: Calling file path (defaults to `#file`).
///   - lineNumber: Calling line number (defaults to `#line`).
///   - function: Calling function (defaults to `#function`).
public func logToDebugger(items: Any...,
                          path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    var text = "\n\n"
    for (index, element) in items.enumerated() {
        let type = Mirror(reflecting: element).subjectType
        let description = String(reflecting: element)
        text += "#\(index): \(type) | \(description)\n"
    }
    logToDebugger(text, path: path, lineNumber: lineNumber, function: function)
}
