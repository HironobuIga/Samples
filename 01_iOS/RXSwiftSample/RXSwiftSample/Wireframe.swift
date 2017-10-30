//
//  Wireframe.swift
//  RXSwiftSample
//
//  Created by 伊賀裕展 on 2017/10/30.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum RetryResult {
    case retry, cancel
}

protocol Wireframe {
    func open(url: URL)
    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
}

class DefaultWireframe: Wireframe {
    static let shared = DefaultWireframe()
    
    func open(url: URL) {
        UIApplication.shared.open(url)
    }
    
    private static func rootViewController() -> UIViewController {
        return UIApplication.shared.keyWindow!.rootViewController!
    }
    
    static func presentAlert(_ message: String) {
        let alertView = UIAlertController(title: "RXExample", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
        }))
        rootViewController().present(alertView, animated: true, completion: nil)
    }
    
    func promptFor<Action>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action> where Action : CustomStringConvertible {
        return Observable.create { observer in
            let alertView = UIAlertController(title: "RxExample", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel, handler: {_ in
                observer.on(.next(cancelAction))
            }))
            
            for action in actions {
                alertView.addAction(UIAlertAction(title: action.description, style: .default, handler: { _ in
                    observer.on(.next(action))
                })
                )
            }
            
            DefaultWireframe.rootViewController().present(alertView, animated: true, completion: nil)
            
            return Disposables.create {
                alertView.dismiss(animated: false, completion: nil)
            }
        }
    }
}


extension RetryResult: CustomStringConvertible {
    var description: String {
        switch  self {
        case .retry: return "Retry"
        case .cancel: return "Cancel"
        }
    }
}
