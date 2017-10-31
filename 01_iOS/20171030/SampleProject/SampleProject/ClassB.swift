//
//  ClassB.swift
//  SampleProject
//
//  Created by 伊賀裕展 on 2017/10/30.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit

class ClassB: ClassA {
    
    func functionC() {
        self.functionA()
    }
    
    override internal func functionB() {
        print("functionB subClass")
    }
}
