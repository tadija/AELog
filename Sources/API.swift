/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

// MARK: - API / Main

public func logToDebugger(_ text: String = "",
                          path: String = #file, lineNumber: Int = #line, function: String = #function)
{
    Log.shared.print(mode: .print,
                     thread: Thread.current,
                     path: path,
                     lineNumber: lineNumber,
                     function: function,
                     text: text)
}

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
