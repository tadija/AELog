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
        aelog(sender)
        generateLogLines(count: Int.random(max: 218))
    }

}