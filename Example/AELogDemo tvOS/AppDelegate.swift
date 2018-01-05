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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        log()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        log()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        log()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        log()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        log()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        log()
    }

}

