//
//  ResultViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import Foundation

protocol ResultViewModelProtocol {
    func goToSubscribeViewController()
}


class ResultViewModel {
    
    private var coordinator: ResultCoordinatorProtocol
    
    init(coordinator: ResultCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToSubscribreViewController() {
        coordinator.goToSubscribreViewController()
    }
}
