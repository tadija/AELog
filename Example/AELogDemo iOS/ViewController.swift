/**
 *  https://github.com/tadija/AELog
 *  Copyright © 2016-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import UIKit
import AELog

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aelog()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aelog()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        aelog()

        let text = "One two three four five"
        let x: CGFloat = 21
        let y: CGFloat = 8
        let size = CGSize(width: 19, height: 84)
        let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        let range = 1...5
        aelog(text, x, y, size, rect, range, Log.shared, self)

        queue.async {
            aelog("This is coming from background thread.")
        }

        aelog("This will be logged to device console.", mode: .nsLog)
    }

    private let queue = DispatchQueue(label: "Custom")
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                aelog(sender)
            })
        }
    }
    
}
