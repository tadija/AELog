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
        log()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.async {
            generateLogLines(count: Int.random(max: 1000))
            DispatchQueue.main.async(execute: {
                log(message: sender)
            })
        }
    }
    
}
