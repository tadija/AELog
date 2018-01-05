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
        log()
    }

    override func willActivate() {
        super.willActivate()
        log()
    }

    override func didDeactivate() {
        super.didDeactivate()
        log()
    }
    
    @IBAction func didTapButton() {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                log()
            })
        }
    }
    
}
