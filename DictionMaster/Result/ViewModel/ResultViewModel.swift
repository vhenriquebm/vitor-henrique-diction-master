//
//  ResultViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import Foundation

class ResultViewModel: ResultViewModelProtocol {
    private var coordinator: ResultCoordinatorProtocol
    private var searchResponse:[SearchWordResponse]
    
    init(coordinator: ResultCoordinatorProtocol, searchResponse:[SearchWordResponse]) {
        self.coordinator = coordinator
        self.searchResponse = searchResponse
    }
    
    func dismiss() {
        coordinator.back()
    }
    
    var getResult: [SearchWordResponse] {
        return self.searchResponse
    }
    
    func backToRoot() {
        coordinator.backToRootViewController()
    }
}
