//
//  SubscribeViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit
import RxSwift
import RxCocoa

class SubscribeViewController: ViewController {
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var firstText: UILabel!
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel:SubscribeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func configureViews() {
        firstText.font = UIFont.sf_pro_rounded_bold(size: 20)
        
        secondText.font = UIFont.sf_pro_rounded_bold(size: 20)
        
        subscribeButton.layer.cornerRadius = 10
        subscribeButton.titleLabel?.font = UIFont.sf_pro_rounded_bold(size: 18)
    }
    
    override func configureBindings() {
        subscribeButton.rx
            .tap
            .subscribe(onNext: backToRoot)
            .disposed(by: disposeBag)
    }
    
    private func backToRoot(){
        self.viewModel?.backToRoot()
    }
}
