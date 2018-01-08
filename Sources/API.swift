/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - API / Main

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
    Log.shared.print(mode: .print,
                     thread: Thread.current,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     text: text)
    debugPrint()
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
    Log.shared.print(mode: .nsLog,
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
