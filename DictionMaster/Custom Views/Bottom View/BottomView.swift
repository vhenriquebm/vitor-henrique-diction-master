//
//  BottomView.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 06/02/24.
//

import UIKit
import RxSwift
import RxCocoa

typealias VoidFunc = () -> Void

class BottomView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tryAnotherSearchLabel: UILabel!
    @IBOutlet weak var newSearchButton: UIButton!
    
    private var action: VoidFunc?
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
        configureBindings()
    }
    
    private func configureViews() {
        titleLabel.font = UIFont.sf_pro_rounded_bold(size: 24)
        
        tryAnotherSearchLabel.font = UIFont.sf_pro_rounded_regular(size: 16)
        
        newSearchButton.titleLabel?.font = UIFont.sf_pro_rounded_bold(size: 18)
        
        newSearchButton.layer.cornerRadius = 10
    }
    
    private func configureBindings() {
        newSearchButton.rx
            .tap
            .subscribe(onNext: backToRoot)
            .disposed(by: disposeBag)
    }
    
    private func backToRoot() {
        guard let action = action else { return }
        action()
    }
    
    func configure(action: VoidFunc?) {
        self.action = action
    }
}
