//
//  ViewController.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/08.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputTextField.rx.text.orEmpty
        .throttle(1.0, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
                self?.label.text = text
            })
        .disposed(by: disposeBag)
    }
}

