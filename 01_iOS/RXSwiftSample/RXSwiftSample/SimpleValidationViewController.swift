//
//  SimpleValidationViewController.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/10.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

private let minumumUserNameLength = 5
private let minumumPassWordLength = 5

class SimpleValidationViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextArea: UITextField!
    @IBOutlet weak var usernameAlertLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextArea: UITextField!
    @IBOutlet weak var passwordAlertLabel: UILabel!
    
    @IBOutlet weak var enterButton: UIButton!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameAlertLabel.text = "ユーザーネームは\(minumumUserNameLength)以上入力してください"
        passwordAlertLabel.text = "ユーザーネームは\(minumumPassWordLength)以上入力してください"
        
        // shareReplayが何をやっているか
        // coldobservableで通常の接続をした場合は、ストリームは別に１つ作られる
        // shareReplayでhotObbservableにした場合は、元のストリームから分岐する
        // cold A->B->C A->B'->C'の２つできる
        // hot A->B->C
        //      |
        //      -> B'->C'となる
        //コンポーネント等で提供する場合は意図しないストリーム分割が起きないよう hot coldを意識する
        
        let usernameValid = usernameTextArea.rx.text.orEmpty
            .map { $0.count >= minumumUserNameLength }
            .share(replay: 1, scope: .whileConnected)

        let passwordValid = passwordTextArea.rx.text.orEmpty
            .map { $0.count >= minumumPassWordLength }
            .share(replay: 1, scope: .whileConnected)
        
        let everyThingValid = Observable.combineLatest(usernameValid, passwordValid)
        { $0 && $1 }
        .share(replay: 1)
        
        usernameValid.bind(to: passwordTextArea.rx.isEnabled)
        .disposed(by: disposeBag)
        
        usernameValid.bind(to: usernameAlertLabel.rx.isHidden)
        .disposed(by: disposeBag)
        
        passwordValid.bind(to: passwordAlertLabel.rx.isHidden)
        .disposed(by: disposeBag)
        
        everyThingValid.bind(to: enterButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        enterButton.rx.tap
        .subscribe(onNext: { [weak self] in self?.showAlert() })
        .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let vc = UIAlertController(title: "example",
                                   message: "this is awsome",
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        vc.addAction(okAction)
        self.present(vc, animated: true, completion: nil)
    }
}
