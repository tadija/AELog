/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit
import AELog

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logToDebugger()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logToDebugger()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logToDebugger()

        let text = "One two three four five"
        let x: CGFloat = 21
        let y: CGFloat = 8
        let size = CGSize(width: 19, height: 84)
        let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        let range = 1...5
        logToDebugger(items: text, x, y, size, rect, range, Log.shared, self)

        queue.async {
            logToDebugger("This is coming from background thread")
        }
    }

    private let queue = DispatchQueue(label: "Custom")
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                logToDebugger(sender)
            })
        }
    }
    
}
