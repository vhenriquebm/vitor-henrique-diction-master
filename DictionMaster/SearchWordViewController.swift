//
//  ViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit

class SearchWordViewController: ViewController {
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchWordButton: UIButton!
    

    var delegate: SearchNewWordProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = SearchNewViewModel(service: SearchNewWordService())
        searcNewWord()
    }
    
    override func configureViews() {
        
    }
    
    override func configureBindings() {
        
    }
    
    private func searcNewWord() {
        delegate?.searchNewWord(with: "dog")
    }
}

