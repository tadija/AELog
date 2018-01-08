/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AELog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let settings = Log.shared.settings

         /// - Note: It's recommended to enable logging only in DEBUG mode.
        settings.isEnabled = true

        /// - Note: Customize format of log lines like this, these are defaults:
        settings.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        settings.template = "{date} -- [{thread}] {file} ({line}) -> {function} > {message}"

        logToDebugger()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        logToDebugger()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        logToDebugger()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        logToDebugger()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        logToDebugger()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        logToDebugger()
    }

}
