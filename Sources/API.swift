/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - API / Main

public func logToDebugger(_ message: Any = "",
    thread: Thread = .current, path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.print(mode: .print,
                     thread: thread,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     message: "\(message)")
}

public func logToDevice(_ message: Any = "",
    thread: Thread = .current, path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.print(mode: .nsLog,
                     thread: thread,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     message: "\(message)")
}

// MARK: - API / Convenience

public func logToDebugger(items: Any...,
    thread: Thread = .current, path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    var message = "\n\n"
    for (index, element) in items.enumerated() {
        let mirror = Mirror(reflecting: element)
        message += "#\(index): \(mirror.subjectType) | \(element)\n"
    }
    logToDebugger(message, thread: thread, path: path, lineNumber: lineNumber, function: function)
}
