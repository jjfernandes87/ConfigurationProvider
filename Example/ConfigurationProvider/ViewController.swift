//
//  ViewController.swift
//  ConfigurationProvider
//
//  Created by jjfernandes87 on 12/03/2017.
//  Copyright (c) 2017 jjfernandes87. All rights reserved.
//

import UIKit
import ConfigurationProvider

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value: String = ConfigurationProvider.shared().get("name") {
            label.text = value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

