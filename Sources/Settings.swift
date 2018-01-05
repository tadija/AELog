//
//  Settings.swift
//  AELog iOS
//
//  Created by Marko Tadić on 1/5/18.
//  Copyright © 2018 AE. All rights reserved.
//

import Foundation

open class Settings {

    // MARK: Constants

    private struct Defaults {
        static let isEnabled = true
        static let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        static let template = "{date} -- [{thread}] {file} ({line}) -> {function} > {message}"
    }

    // MARK: Singleton

    public static let shared = Settings()

    // MARK: Properties

    public var isEnabled = Defaults.isEnabled

    public var dateFormat = Defaults.dateFormat
    public var template = Defaults.template

    public var files = [String : Bool]()

    let dateFormatter = DateFormatter()

    // MARK: Init

    init() {
        dateFormatter.dateFormat = dateFormat
    }

}
