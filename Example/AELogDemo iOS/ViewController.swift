//
//  ViewController.swift
//  AELogDemo
//
//  Created by Marko Tadic on 4/1/16.
//  Copyright © 2016 AE. All rights reserved.
//

import UIKit
import AELog

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aelog()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        aelog()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        aelog()
    }
    
    @IBAction func didTapButton(sender: UIButton) {
        aelog(sender)
        generateLogLines(count: Int.random(max: 218))
    }
    
}