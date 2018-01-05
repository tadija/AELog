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

        let x: CGFloat = 21
        let y: CGFloat = 8
        let size = CGSize(width: 19, height: 84)
        let rect = CGRect(x: x, y: y, width: size.width, height: size.height)
        log(objects: x, y, size, rect)
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
