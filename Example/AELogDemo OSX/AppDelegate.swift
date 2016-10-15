//
//  AppDelegate.swift
//  AELogDemo OSX
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

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

