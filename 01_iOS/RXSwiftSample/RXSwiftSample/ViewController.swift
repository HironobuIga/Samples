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

enum CellIdentifier: String {
    case addingNumber = "addingNumber"
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let order: [CellIdentifier] = [.addingNumber]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.inputTextField.rx.text.orEmpty
        .throttle(1.0, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
                self?.label.text = text
            })
        .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let sb = UIStoryboard(name: "AddingNumberViewController", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "AddingNumberViewController") as? AddingNumberViewController else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: order[indexPath.row].rawValue)!
    }
}
