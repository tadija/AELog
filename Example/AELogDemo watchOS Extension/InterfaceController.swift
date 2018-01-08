/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import WatchKit
import Foundation
import AELog

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        logToDebugger()
    }

    override func willActivate() {
        super.willActivate()
        logToDebugger()
    }

    override func didDeactivate() {
        super.didDeactivate()
        logToDebugger()
    }
    
    @IBAction func didTapButton() {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                logToDebugger()
            })
        }
    }
    
}
