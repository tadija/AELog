/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Cocoa
import AELog

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logToDebugger()
    }

    override var representedObject: Any? {
        didSet {
            logToDebugger()
        }
    }

    @IBAction func didTapButton(_ sender: NSButtonCell) {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                logToDebugger(items: sender)
            })
        }
    }

}
