//
// Settings.swift
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

/**
    Helper for accessing settings from the external file.

    Create `AELog.plist` dictionary file and add it to your target.

    There is `Key` struct which contains possible keys for all settings.
*/
open class Settings {
    
    // MARK: Constants
    
    /// Setting keys which can be used in `AELog.plist` dictionary.
    public struct Key {
        /// Boolean - Logging enabled flag (defaults to `NO`)
        public static let Enabled = "Enabled"
        
        /// Dictionary - Key: file name without extension, Value: Boolean (defaults to empty - all files log enabled)
        public static let Files = "Files"
        
        /// String - Date format which will be used in log lines. (defaults to "yyyy-MM-dd HH:mm:ss.SSS")
        public static let DateFormat = "DateFormat"
        
        /// String - Log lines template. (defaults to "{date} -- [{thread}] {file} ({line}) -> {function} > {message}")
        public static let Template = "Template"
    }
    
    private struct Default {
        static let Enabled = false
        static let DateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        static let Template = "{date} -- [{thread}] {file} ({line}) -> {function} > {message}"
    }
    
    // MARK: Properties
    
    let dateFormatter = DateFormatter()
    
    /// Contents of AELog settings (AELog.plist file or AELog dictionary from Info.plist)
    open private(set) lazy var plist: [String : AnyObject]? = {
        guard let
            path = Bundle.main.path(forResource: "AELog", ofType: "plist"),
            let settings = NSDictionary(contentsOfFile: path) as? [String : AnyObject]
        else { return self.infoPlist }
        return settings
    }()
    
    open private(set) lazy var infoPlist: [String : AnyObject]? = {
        guard let settings = Bundle.main.infoDictionary?["AELog"] as? [String : AnyObject]
        else { return nil }
        return settings
    }()
    
    // MARK: Init
    
    public init() {
        dateFormatter.dateFormat = dateFormat
    }
    
    // MARK: Settings
    
    lazy var isEnabled: Bool = { [unowned self] in
        guard let
            settings = self.plist,
            let enabled = settings[Key.Enabled] as? Bool
        else { return Default.Enabled }
        return enabled
    }()
    
    lazy var files: [String : Bool]? = { [unowned self] in
        guard let
            settings = self.plist,
            let files = settings[Key.Files] as? [String : Bool]
        else { return nil }
        return files
    }()
    
    lazy var dateFormat: String? = { [unowned self] in
        guard let
            settings = self.plist,
            let format = settings[Key.DateFormat] as? String
        else { return Default.DateFormat }
        return format
    }()
    
    lazy var template: String = { [unowned self] in
        guard let
            settings = self.plist,
            let template = settings[Key.Template] as? String
        else { return Default.Template }
        return template
    }()
    
}
