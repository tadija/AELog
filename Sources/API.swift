/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    - NOTE: If `Log.shared.settings.isEnabled == false` this will do nothing.

    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into the standard output.

    You can optionally provide custom message to be added at the end of a log line.

    - parameter message: Custom text which will be added at the end of a log line
*/
public func debugLog(_ message: Any = "", path: String = #file, lineNumber: Int = #line, function: String = #function) {
    let thread = Thread.current
    Log.shared.log(thread: thread, path: path, lineNumber: lineNumber, function: function, message: "\(message)")
}

/**
    - NOTE: If `Log.shared.settings.isEnabled == false` this will do nothing.

    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into the standard output.

    Message will automatically be provided at the end of a log line made from input parameters.

    - parameter elements: collection of type `Any`.
*/
public func debugLog(variables: Any..., path: String = #file, lineNumber: Int = #line, function: String = #function) {
    var message = "\n\n"
    for (index, element) in variables.enumerated() {
        let mirror = Mirror(reflecting: element)
        message += "\(index): \(mirror.subjectType) | \(element)\n"
    }
    debugLog(message, path: path, lineNumber: lineNumber, function: function)
}
