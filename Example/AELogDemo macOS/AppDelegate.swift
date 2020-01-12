/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import Cocoa
import AELog

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        aelog()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        aelog()
    }

}
