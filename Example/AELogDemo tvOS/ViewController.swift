/**
 *  https://github.com/tadija/AELog
 *  Copyright (c) Marko Tadić 2016-2019
 *  Licensed under the MIT license. See LICENSE file.
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
    }
    
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
