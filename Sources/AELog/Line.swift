/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2022 Marko Tadić
 *  Licensed under the MIT license
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
    
    /// Custom text
    public let text: String
    
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
    
    internal init(thread: Thread, file: String, number: Int, function: String, text: String) {
        self.date = Date()
        self.thread = thread
        self.file = file
        self.number = number
        self.function = function
        self.text = text
    }
    
    // MARK: CustomStringConvertible
    
    /// Concatenated text representation of a complete log line
    public var description: String {
        let date = Log.shared.settings.dateFormatter.string(from: self.date)
        return parse(
            date: date,
            thread: threadName,
            file: file,
            number: number,
            function: function,
            text: text
        )
    }

    /// Concatenated text representation of a log line without timestamp
    public var descriptionWithoutTimestamp: String {
        return parse(
            thread: threadName,
            file: file,
            number: number,
            function: function,
            text: text
        )
    }
    
    private func parse(date: String? = nil,
                       thread: String,
                       file: String,
                       number: Int,
                       function: String,
                       text: String) -> String
    {
        let result = Log.shared.settings.template
            .replacingOccurrences(of: "{date}", with: date ?? "*")
            .replacingOccurrences(of: "{thread}", with: thread)
            .replacingOccurrences(of: "{file}", with: file)
            .replacingOccurrences(of: "{line}", with: "\(number)")
            .replacingOccurrences(of: "{function}", with: function)
            .replacingOccurrences(of: "{text}", with: text)
        return result
    }
    
}
