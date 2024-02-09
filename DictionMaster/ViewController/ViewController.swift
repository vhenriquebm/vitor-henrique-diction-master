//
//  ViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        configureViews()
        configureBindings()
    }
    
    public func configureViews(){}
    public func configureBindings(){}
}
