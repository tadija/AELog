/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into debugger console (using `print` internally).

    You can optionally provide custom message to be added at the end of a log line.

    - Note: If `Log.shared.settings.isEnabled == false` this will do nothing.

    - parameter message: Custom text which will be added at the end of a log line
*/
public func debugLog(_ message: Any = "",
                     path: String = #file, lineNumber: Int = #line, function: String = #function) {
    Log.shared.log(mode: .print,
                   thread: Thread.current,
                   path: path,
                   lineNumber: lineNumber,
                   function: function,
                   message: "\(message)")
}

/**
    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into debugger console (using `debugPrint` internally).

    Message will be made from ordered input parameters and provided in a log line.

    - Note: If `Log.shared.settings.isEnabled == false` this will do nothing.

    - parameter elements: collection of type `Any`.
*/
public func debugLog(variables: Any...,
                     path: String = #file, lineNumber: Int = #line, function: String = #function) {
    var message = "\n\n"
    for (index, element) in variables.enumerated() {
        let mirror = Mirror(reflecting: element)
        message += "\(index): \(mirror.subjectType) | \(element)\n"
    }
    Log.shared.log(mode: .debugPrint,
                   thread: Thread.current,
                   path: path,
                   lineNumber: lineNumber,
                   function: function,
                   message: "\(message)")
}

/**
    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into debugger and device console (using `NSLog` internally).

    You can optionally provide custom message to be added at the end of a log line.

    - Warning: This will work even if `Log.shared.settings.isEnabled == false`.

    - parameter message: Custom text which will be added at the end of a log line
*/
public func deviceLog(_ message: Any = "",
                      path: String = #file, lineNumber: Int = #line, function: String = #function) {
    Log.shared.log(mode: .nsLog,
                   thread: Thread.current,
                   path: path,
                   lineNumber: lineNumber,
                   function: function,
                   message: "\(message)")
}
