//
//  SearchNewViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation

class SearchNewViewModel: SearchNewWordProtocol {
    private let service: SearchNewWordServiceProtocol?
    
    init(service: SearchNewWordServiceProtocol) {
        self.service = service
    }
    
    func searchNewWord(with word: String) {
        service?.searchNewWord(with: word, completion: { response in
            
            switch response {
            case let .success(searchResult):
                print (searchResult)
            case let .failure(error):
                print (error)
            }
        })
    }
}
