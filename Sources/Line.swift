/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/// Custom data structure used for log lines.
public struct Line: CustomStringConvertible {
    
    // MARK: Properties
    
    /// Timestamp
    public let date: Date
    
    /// Thread
    public let thread: Thread
    
    /// Filename (without extension)
    public let file: String
    
    /// Line number in code
    public let number: Int
    
    /// Function
    public let function: String
    
    /// Custom message
    public let message: String
    
    private var threadName: String {
        if thread.isMainThread {
            return "Main"
        } else if let name = thread.name, !name.isEmpty {
            return name
        } else {
            return String(format:"%p", thread)
        }
    }
    
    // MARK: Init
    
    init(thread: Thread, file: String, number: Int, function: String, message: String) {
        self.date = Date()
        self.thread = thread
        self.file = file
        self.number = number
        self.function = function
        self.message = message
    }
    
    // MARK: CustomStringConvertible
    
    /// Concatenated text representation of a complete log line
    public var description: String {
        let date = Log.shared.settings.dateFormatter.string(from: self.date)
        let text = parse(date: date, thread: threadName, file: file, number: number, function: function, message: message)
        return text
    }
    
    private func parse(date: String,
                       thread: String,
                       file: String,
                       number: Int,
                       function: String,
                       message: String) -> String
    {
        let result = Log.shared.settings.template
            .replacingOccurrences(of: "{date}", with: date)
            .replacingOccurrences(of: "{thread}", with: thread)
            .replacingOccurrences(of: "{file}", with: file)
            .replacingOccurrences(of: "{line}", with: "\(number)")
            .replacingOccurrences(of: "{function}", with: function)
            .replacingOccurrences(of: "{message}", with: message)
        return result
    }
    
}
