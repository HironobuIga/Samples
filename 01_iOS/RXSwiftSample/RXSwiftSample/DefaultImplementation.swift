//
//  DefaultImplementation.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/26.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxSwift

class GitHubDefaultValidationService: GitHubValidationService {
    let API: GitHubAPI
    
    static let sharedValidationService = GitHubDefaultValidationService(API: GitHubDefaultAPI.sharedAPI)
    
    init(API: GitHubAPI) {
        self.API = API
    }
    
    let minPasswordCount = 5
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.count <= 0 {
            return .just(.empty)
        }
        
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "Username can only contain numbers or digits"))
        }
        
        let loadingValue = ValidationResult.validating
        
        return API
        .usernameAvailable(username)
            .map{ available in
                if available {
                    return .ok(message: "Username Available")
                } else {
                    return .failed(message: "Usename already taken")
                }
        }.startWith(loadingValue) // 流れる値の先頭にstartWith(hoge)のhogeを流す
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters <= 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        return .ok(message: "Password acceptable")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count <= 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "Password repeated")
        } else {
            return .failed(message: "Password different")
        }
    }
}

class GitHubDefaultAPI: GitHubAPI {
    let URLSession: URLSession
    
    static let sharedAPI = GitHubDefaultAPI(URLSession: .shared)
    
    init(URLSession: URLSession) {
        self.URLSession = URLSession
    }
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request)
            .map { pair in
                return pair.response.statusCode == 404
        }
        .catchErrorJustReturn(false)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        let signupResult = arc4random() % 5 == 0
        return Observable.just(signupResult)
            // justを使用すると just(hoge)のhogeをObservable<hoge>に変換できる
            // justは一つのobservable、from(hoge)は複数のObservableを流す
        .delay(1.0, scheduler: MainScheduler.instance)
        // delay 流れて来た値を遅延して流す
        // delaySubscription 購読自体を遅延させる
    }
}
