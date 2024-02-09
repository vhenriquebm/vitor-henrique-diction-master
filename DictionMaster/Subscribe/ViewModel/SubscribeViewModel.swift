//
//  SubscribeViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import Foundation

class SubscribeViewModel: SubscribeViewModelProtocol  {
    private var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func backToRoot() {
        coordinator.backToRootViewController()
    }
}
