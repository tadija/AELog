/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
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
