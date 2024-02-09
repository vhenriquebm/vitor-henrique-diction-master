//
//  ViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchWordViewController: ViewController {
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchWordButton: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var viewModel: SearchNewViewModel?
    private var isHidden = BehaviorSubject(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        headerView.layer.cornerRadius = 10
        
        searchWordButton.titleLabel?.font = UIFont.sf_pro_rounded_bold(size: 18)
        searchWordButton.layer.cornerRadius = 10
        
        searchWordTextField.font = UIFont.sf_pro_rounded_bold(size: 32)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sf_pro_rounded_regular(size: 32) ?? UIFont.systemFont(ofSize: 32),
            .foregroundColor: UIColor.customDarkGray
        ]
        
        searchWordTextField.attributedPlaceholder = NSAttributedString(string: "Type a word...",
                                                                       attributes: placeholderAttributes)
    }
    
    override func configureBindings() {
        searchWordButton.rx
            .tap
            .subscribe(onNext: searcNewWord )
            .disposed(by: disposeBag)
        
        viewModel?.isLoading
            .subscribe(onNext: isLoading)
            .disposed(by: disposeBag)
        
        searchWordTextField.rx.text.orEmpty
            .map { $0.isEmpty }
            .bind(to: searchWordButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        searchWordTextField.rx.text.orEmpty
            .map { $0.capitalizedFirstLetter() }
            .bind(to: searchWordTextField.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func isLoading(loading: Bool) {
        loadingView.isHidden = !loading
        searchWordTextField.isHidden = loading
    }
    
    private func searcNewWord() {
        guard let word = searchWordTextField.text, !word.isEmpty else {
            return }
        
        viewModel?.searchNewWord(with:word)
    }
}

