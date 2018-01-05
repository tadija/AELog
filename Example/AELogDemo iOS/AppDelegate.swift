//
//  AppDelegate.swift
//  AELogDemo
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

import UIKit
import AELog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
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
