//
//  AppDelegate.swift
//  AELogDemo tvOS
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

import UIKit
import AELog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        aelog()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        aelog()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        aelog()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        aelog()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        aelog()
    }

    func applicationWillTerminate(application: UIApplication) {
        aelog()
    }

}

