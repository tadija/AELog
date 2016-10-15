//
//  InterfaceController.swift
//  AELogDemo watchOS Extension
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

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
