/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import WatchKit
import AELog

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        aelog()
    }

    func applicationDidBecomeActive() {
        aelog()
    }

    func applicationWillResignActive() {
        aelog()
    }

}
