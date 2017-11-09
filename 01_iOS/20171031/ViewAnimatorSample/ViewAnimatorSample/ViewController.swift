//
//  ViewController.swift
//  ViewAnimatorSample
//
//  Created by 伊賀裕展 on 2017/10/31.
//  Copyright © 2017年 伊賀裕展. All rights reserved.
//

import UIKit
import ViewAnimator

class ViewController: UIViewController {
    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTouchUpInsideDirectionButton(_ sender: Any) {
        let fromAnimation = AnimationType.from(direction: .left, offset: 30.0)
//        let toAnimation = AnimationType.from(direction: .left, offset: 30.0)
        targetView.animate(animations: [fromAnimation])
    }
    
    @IBAction func didTouchUpInsideZoomButton(_ sender: UIButton) {
        let biggerAnimation = AnimationType.zoom(scale: 2.0)
        let smallerAnimation = AnimationType.zoom(scale: 0.5)
        targetView.animateAll(animations: [biggerAnimation, smallerAnimation], interval: 1.0)
    }
    
    @IBAction func didTouchUpInsideRotateButton(_ sender: UIButton) {
        let leftRotateAnimation = AnimationType.rotate(angle: CGFloat(-0.5 * Float.pi))
        let rightRotateAnimation = AnimationType.rotate(angle: CGFloat(0.5 * Float.pi))
        targetView.animate(animations: [leftRotateAnimation, rightRotateAnimation],
                           initialAlpha: 0.5,
                           finalAlpha: 1.0,
                           delay: 1.0,
                           duration: 1.0,
                           completion: nil)
    }
    
    @IBAction func didTouchUpInsideCombinationButton(_ sender: UIButton) {
    }
    
}

