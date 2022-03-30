/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2022 Marko Tadić
 *  Licensed under the MIT license
 */

import WatchKit
import Foundation
import AELog

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        aelog()
    }

    override func willActivate() {
        super.willActivate()
        aelog()
    }

    override func didDeactivate() {
        super.didDeactivate()
        aelog()
    }
    
    @IBAction func didTapButton() {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                aelog()
            })
        }
    }
    
}
