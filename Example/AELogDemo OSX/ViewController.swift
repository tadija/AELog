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

    override var representedObject: Any? {
        didSet {
            aelog()
        }
    }

    @IBAction func didTapButton(_ sender: NSButtonCell) {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                aelog(sender)
            })
        }
    }

}
