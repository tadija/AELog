//
// AELog.swift
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

// MARK: - Top Level

/** 
    Writes the textual representations of current timestamp, thread name,
    file name, line number and function name into the standard output.
 
    You can optionally provide custom message to be added at the end of a log line.
 
    - NOTE: If `AELog` setting "Enabled" is set to "NO" this will do nothing.
 
    - parameter message: Custom text which will be added at the end of a log line
*/
public func aelog(_ message: Any = "", path: String = #file, line: Int = #line, function: String = #function) {
    let thread = Thread.current
    AELog.sharedInstance.log(thread: thread, path: path, line: line, function: function, message: "\(message)")
}

// MARK: - AELog

/// Handles logging called from `aelog` top-level function.
open class AELog {
    
    // MARK: Properties
    
    fileprivate static let sharedInstance = AELog()
    fileprivate let settings = AELogSettings()
    fileprivate weak var delegate: AELogDelegate?
    fileprivate let logQueue = DispatchQueue(label: "AELog", attributes: [])
    
    // MARK: API

    /// Configures delegate for `AELog` singleton. Use this if you need additional functionality after each line of log.
    open class func launchWithDelegate(_ delegate: AELogDelegate) {
        AELog.sharedInstance.delegate = delegate
    }
    
    fileprivate func log(thread: Thread, path: String, line: Int, function: String, message: String) {
        logQueue.async { [unowned self] in
            if self.settings.enabled {
                let file = self.fileNameForPath(path)
                if self.fileEnabled(file) {
                    
                    let logLine = AELogLine(thread: thread, file: file, line: line, function: function, message: message)
                    print(logLine.description)
                    
                    DispatchQueue.main.async(execute: {
                        self.delegate?.didLog(logLine)
                    })
                }
            }
        }
    }
    
    // MARK: Helpers
    
    fileprivate func fileNameForPath(_ path: String) -> String {
        guard let
            fileName = NSURL(fileURLWithPath: path).deletingPathExtension?.lastPathComponent
        else { return "Unknown" }
        return fileName
    }
    
    fileprivate func fileEnabled(_ fileName: String) -> Bool {
        guard let
            files = settings.files,
            let fileEnabled = files[fileName]
        else { return true }
        return fileEnabled
    }
    
}

// MARK: - AELogDelegate

/// Forwards logged lines via `didLog:` function.
public protocol AELogDelegate: class {
    func didLog(_ logLine: AELogLine)
}

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
    
    fileprivate init(thread: Thread, file: String, line: Int, function: String, message: String) {
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
        let date = AELog.sharedInstance.settings.dateFormatter.string(from: self.date)
        let desc = parse(date: date, thread: threadName, file: file, line: line, function: function, message: message)
        return desc
    }
    
    fileprivate func parse(
        date: String, thread: String, file: String, line: Int, function: String, message: String) -> String {
        let result = AELog.sharedInstance.settings.template
            .replacingOccurrences(of: "{date}", with: date)
            .replacingOccurrences(of: "{thread}", with: thread)
            .replacingOccurrences(of: "{file}", with: file)
            .replacingOccurrences(of: "{line}", with: "\(line)")
            .replacingOccurrences(of: "{function}", with: function)
            .replacingOccurrences(of: "{message}", with: message)
        return result
    }
    
}

// MARK: - AELogSettings

/**
    Helper for accessing settings from the external file.
 
    Create `AELog.plist` dictionary file and add it to your target.
 
    There is `Key` struct which contains possible keys for all settings.
*/
open class AELogSettings {
    
    // MARK: Constants
    
    /// Setting keys which can be used in `AELog.plist` dictionary.
    public struct Key {
        /// Boolean - Logging enabled flag (defaults to `YES`)
        public static let Enabled = "Enabled"
        
        /// Dictionary - Key: file name without extension, Value: Boolean (defaults to empty - all files log enabled)
        public static let Files = "Files"
        
        /// String - Date format which will be used in log lines. (defaults to "yyyy-MM-dd HH:mm:ss.SSS")
        public static let DateFormat = "DateFormat"
        
        /// String - Log lines template. (defaults to "{date} -- [{thread}] {file} ({line}) -> {function} > {message}")
        public static let Template = "Template"
    }
    
    fileprivate struct Default {
        fileprivate static let Enabled = true
        fileprivate static let DateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        fileprivate static let Template = "{date} -- [{thread}] {file} ({line}) -> {function} > {message}"
    }
    
    // MARK: Properties
    
    fileprivate let dateFormatter = DateFormatter()
    
    /// Contents of `AELog.plist` file
    open fileprivate(set) lazy var plist: [String : AnyObject]? = {
        guard let
            path = Bundle.main.path(forResource: "AELog", ofType: "plist"),
            let settings = NSDictionary(contentsOfFile: path) as? [String : AnyObject]
        else { return nil }
        return settings
    }()
    
    // MARK: Init
    
    public init() {
        dateFormatter.dateFormat = dateFormat
    }
    
    // MARK: Settings
    
    fileprivate lazy var enabled: Bool = { [unowned self] in
        guard let
            settings = self.plist,
            let enabled = settings[Key.Enabled] as? Bool
        else { return Default.Enabled }
        return enabled
    }()
    
    fileprivate lazy var files: [String : Bool]? = { [unowned self] in
        guard let
            settings = self.plist,
            let files = settings[Key.Files] as? [String : Bool]
        else { return nil }
        return files
    }()
    
    fileprivate lazy var dateFormat: String? = { [unowned self] in
        guard let
            settings = self.plist,
            let format = settings[Key.DateFormat] as? String
        else { return Default.DateFormat }
        return format
    }()
    
    fileprivate lazy var template: String = { [unowned self] in
        guard let
            settings = self.plist,
            let template = settings[Key.Template] as? String
        else { return Default.Template }
        return template
    }()
    
}
