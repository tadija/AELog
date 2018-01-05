/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/**
    Helper for accessing settings from the external file.

    Create `AELog.plist` dictionary file and add it to your target.
    Alternative is to add `AELog` dictionary inside existing `Info.plist` file.

    There is `Key` struct which contains possible keys for all settings.
*/
public class Config {
    
    // MARK: - Constants
    
    /// Setting keys which can be used in `AELog` dictionary.
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
    
    // MARK: - Properties
    
    let dateFormatter = DateFormatter()
    
    /// Contents of AELog settings (AELog.plist file or AELog dictionary from Info.plist)
    private lazy var data: [String : AnyObject]? = {
        guard let
            path = Bundle.main.path(forResource: "AELog", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path) as? [String : AnyObject]
        else { return self.alternateData }
        return data
    }()
    
    private lazy var alternateData: [String : AnyObject]? = {
        guard let data = Bundle.main.infoDictionary?["AELog"] as? [String : AnyObject]
        else { return nil }
        return data
    }()
    
    // MARK: - Init
    
    init() {
        dateFormatter.dateFormat = dateFormat
    }
    
    // MARK: - Settings
    
    lazy var isEnabled: Bool = { [unowned self] in
        guard let
            data = self.data,
            let enabled = data[Key.Enabled] as? Bool
        else { return Default.Enabled }
        return enabled
    }()
    
    lazy var files: [String : Bool]? = { [unowned self] in
        guard let
            data = self.data,
            let files = data[Key.Files] as? [String : Bool]
        else { return nil }
        return files
    }()
    
    lazy var dateFormat: String? = { [unowned self] in
        guard let
            data = self.data,
            let format = data[Key.DateFormat] as? String
        else { return Default.DateFormat }
        return format
    }()
    
    lazy var template: String = { [unowned self] in
        guard let
            data = self.data,
            let template = data[Key.Template] as? String
        else { return Default.Template }
        return template
    }()
    
}
