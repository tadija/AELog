/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import WatchKit
import AELog

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        log()
    }

    func applicationDidBecomeActive() {
        log()
    }

    func applicationWillResignActive() {
        log()
    }

}
