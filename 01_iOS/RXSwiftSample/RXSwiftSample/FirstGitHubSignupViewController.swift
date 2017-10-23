//
//  FirstGitHubSignupViewController.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/19.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstGitHubSignupViewController: UIViewController {
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var signupOutlet: UIButton!
    @IBOutlet weak var signingupOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
