//
//  AddingNumberViewController.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/09.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddingNumberViewController: UIViewController {
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // combineLatestを使用し、複数のstreamを一つに束ねる
        // orEmptyはoptionalを非optionalに直す
        // 例えばstringではnilの場合はdefaultとして ""　を返す
        Observable.combineLatest(number1.rx.text.orEmpty,
                                 number2.rx.text.orEmpty,
                                 number3.rx.text.orEmpty) {
                                    (textValue1, textValue2, textValue3) -> Int in
                                    return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }.map{ $0.description }
            .bind(to: answerLabel.rx.text) // bindでstreamの結果をつなぐ
            .disposed(by: disposeBag)
        // disposeBagが消えたタイミングでsubscribeが消える
        // つまり上記でdisposeBagが消える、クラスがdeinitしたタイミングでsubscribeが消えることが保証される
    }
}
