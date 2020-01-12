/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import UIKit
import AELog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        aelog()
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

