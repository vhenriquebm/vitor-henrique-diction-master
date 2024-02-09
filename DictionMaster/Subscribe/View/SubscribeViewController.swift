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
        subscribeButton.layer.cornerRadius = 10
        subscribeButton.titleLabel?.font = UIFont.sf_pro_rounded_bold(size: 18)
        
        setFirstTextAttributedText()
        setSecondAttributedText()
    }
    
    private func setFirstTextAttributedText() {
        firstText.font = UIFont.sf_pro_rounded_bold(size: 20)
        
        let text = "Subscribe now to get unlimited searches and full access to all features."
        let attributedString = NSMutableAttributedString(string: text)
        
        let accentWords = ["unlimited", "all", "features"]
        let atributosPalavrasAzuis: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.accent
        ]
        
        for word in accentWords {
            let range = (text as NSString).range(of: word)
            attributedString.addAttributes(atributosPalavrasAzuis, range: range)
        }
        
        firstText.attributedText = attributedString
    }
    
    private func setSecondAttributedText() {
        let text = "Try 7 Days Free, then only $19,99 per year. Cancel anytime."
        let attributedString = NSMutableAttributedString(string: text)
        
        let sf_bold_font = UIFont.sf_pro_rounded_bold(size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        let sf_regular_font = UIFont.sf_pro_rounded_regular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        let range = NSRange(location: 0, length: text.count)
        attributedString.addAttribute(.font, value: sf_regular_font, range: range)
        
        let accentWords = ["Try 7 Days Free", "$19,99"]
        for word in accentWords {
            let range = (text as NSString).range(of: word)
            attributedString.addAttribute(.font, value: sf_bold_font, range: range)
        }
        
        secondText.attributedText = attributedString
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
