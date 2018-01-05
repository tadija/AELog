//
//  ExtensionDelegate.swift
//  AELogDemo watchOS Extension
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

import WatchKit
import AELog

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        log()
    }

    func applicationDidBecomeActive() {
        log()
    }

    func applicationWillResignActive() {
        log()
    }

}
