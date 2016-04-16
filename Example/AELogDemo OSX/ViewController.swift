//
//  ViewController.swift
//  AELogDemo OSX
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

import Cocoa
import AELog

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        aelog()
    }

    override var representedObject: AnyObject? {
        didSet {
            aelog()
        }
    }

    @IBAction func didTapButton(sender: NSButtonCell) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        dispatch_async(queue) {
            generateLogLines(count: Int.random(max: 1000))
            dispatch_async(dispatch_get_main_queue(), {
                aelog(sender)
            })
        }
    }

}