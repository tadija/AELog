//
// Line.swift
//
// Copyright (c) 2016 Marko Tadić <tadija@me.com> http://tadija.net
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

// MARK: - AELogLine

/// Custom data structure used by `AELog` for log lines.
public struct AELogLine: CustomStringConvertible {
    
    // MARK: Properties
    
    /// Timestamp
    public let date: Date
    /// Thread
    public let thread: Thread
    /// Filename (without extension)
    public let file: String
    /// Line of code
    public let line: Int
    /// Function
    public let function: String
    /// Custom message
    public let message: String
    
    fileprivate var threadName: String {
        if thread.isMainThread {
            return "Main"
        } else if let name = thread.name, !name.isEmpty {
            return name
        } else {
            return String(format:"%p", thread)
        }
    }
    
    // MARK: Init
    
    init(thread: Thread, file: String, line: Int, function: String, message: String) {
        self.date = Date()
        self.thread = thread
        self.file = file
        self.line = line
        self.function = function
        self.message = message
    }
    
    // MARK: - CustomStringConvertible
    
    /// Concatenated text representation of a complete log line
    public var description: String {
        let date = AELog.shared.settings.dateFormatter.string(from: self.date)
        let desc = parse(date: date, thread: threadName, file: file, line: line, function: function, message: message)
        return desc
    }
    
    fileprivate func parse(
        date: String, thread: String, file: String, line: Int, function: String, message: String) -> String {
        let result = AELog.shared.settings.template
            .replacingOccurrences(of: "{date}", with: date)
            .replacingOccurrences(of: "{thread}", with: thread)
            .replacingOccurrences(of: "{file}", with: file)
            .replacingOccurrences(of: "{line}", with: "\(line)")
            .replacingOccurrences(of: "{function}", with: function)
            .replacingOccurrences(of: "{message}", with: message)
        return result
    }
    
}
