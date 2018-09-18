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
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        /// - Note: Access log settings
        let settings = Log.shared.settings

        /// - Note: It's recommended to disable logging for public release (defaults to enabled).
        settings.isEnabled = true

        /// - Note: Customize format of log lines like this, these are defaults:
        settings.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        settings.template = "{date} -- [{thread}] {file} ({line}) -> {function} > {text}"

        aelog()
        aelog("hello")
        aelog("hello", 123, true)
        aelog(["a", "b", "c"])
        aelog(["a", "b", "c"], [1, 2, 3])

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        aelog()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        aelog()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        aelog()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        aelog()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        aelog()
    }

}
