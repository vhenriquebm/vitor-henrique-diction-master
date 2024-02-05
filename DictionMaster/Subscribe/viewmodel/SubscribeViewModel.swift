//
//  SubscribeViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import Foundation

class SubscribeViewModel {
    
    private var coordinator: SearchCoordinator
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToRootViewController() {
        coordinator.backToRootViewController()
    }
}
