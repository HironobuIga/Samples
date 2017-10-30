//
//  FirstGithubSignupViewModel.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/23.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

import class Foundation.URLSession
import class Foundation.OperationQueue
import enum Foundation.QualityOfService

class FirstGitHubSIgnupViewModel {
    let validatedUsername: Observable<ValidationResult>
    let ValidatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    let signupEnabled: Observable<Bool>
    let signIn: Observable<Bool>
    let signingIn: Observable<Bool>
    
    init(input:(
        username: Observable<String>,
        passsword: Observable<String>,
        repeatedPassword: Observable<String>,
        loginTaps: Observable<Void>
        ),
         dependency:(
        API: GitHubAPI,
        validationService: GitHubValidationService,
        wireframe: Wireframe))
        {
        
    }
}
