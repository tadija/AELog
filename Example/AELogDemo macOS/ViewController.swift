/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

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
