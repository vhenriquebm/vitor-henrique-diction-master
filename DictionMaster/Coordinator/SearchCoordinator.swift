//
//  Coordinator.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit

class SearchCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchWordViewController()
        //        homeViewController.coordinator = self
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func backToRootViewController() {
        self.navigationController.popViewController(animated: false)
    }
}

extension SearchCoordinator: SearchCoordinatorProtocol {
    func goToResultViewController(){
        let resultViewController = ResultViewController()
        let viewModel = ResultViewModel(coordinator: self)
        
        
        navigationController.pushViewController(resultViewController, animated: true)
    }
}

extension SearchCoordinator: ResultCoordinatorProtocol {
    func goToSubscribreViewController(){
        let subscribeViewController = SubscribeViewController()
        let viewModel = ResultViewModel(coordinator: self)
        navigationController.pushViewController(subscribeViewController, animated: true)
    }
}
