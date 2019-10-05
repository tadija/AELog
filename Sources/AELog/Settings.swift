/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

/// Log settings
open class Settings {

    // MARK: Constants

    private struct Defaults {
        static let isEnabled = true
        static let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        static let template = "{date} -- [{thread}] {file} ({line}) -> {function} > {text}"
    }

    // MARK: Properties

    /// Logging enabled flag (defaults to `true`)
    public var isEnabled = Defaults.isEnabled

    /// Date format which will be used in log lines. (defaults to "yyyy-MM-dd HH:mm:ss.SSS")
    public var dateFormat = Defaults.dateFormat {
        didSet {
            dateFormatter.dateFormat = dateFormat
        }
    }

    /// Log lines template. (defaults to "{date} -- [{thread}] {file} ({line}) -> {function} > {text}")
    public var template = Defaults.template

    /// Key: file name without extension (defaults to empty - logging enabled in all files)
    public var files = [String : Bool]()

    internal let dateFormatter = DateFormatter()

    // MARK: Init

    internal init() {
        dateFormatter.dateFormat = dateFormat
    }

}
