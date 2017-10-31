//
//  ViewController.swift
//  SampleProject
//
//  Created by 伊賀裕展 on 2017/10/30.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let classB = ClassB()
        classB.functionC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

