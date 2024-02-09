//
//  Coordinator.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    let storyboard: UIStoryboard
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.storyboard = UIStoryboard(name: Storyboard.Main.rawValue, bundle: nil)
    }
    
    func start() {
        guard let controller =  storyboard.instantiateViewController(withIdentifier: "SearchWordViewController") as? SearchWordViewController else {
            return
        }
        
        let viewModel = SearchNewViewModel(service: SearchNewWordService(), coordinator: self)
        controller.viewModel = viewModel
        
        navigationController.setViewControllers([controller],animated: true)
        
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
    func backToRootViewController() {
        self.navigationController.popToRootViewController(animated: false)
    }
    
    func showError(message: String) {
        self.navigationController.showError(message: message)
    }
}

extension MainCoordinator: SearchCoordinatorProtocol {
    func goToResultViewController(with searchResponse:[SearchWordResponse]){
        
        guard let controller =  storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {
            return
        }
        
        let viewModel = ResultViewModel(coordinator: self, searchResponse: searchResponse)
        
        controller.viewModel = viewModel
        
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: ResultCoordinatorProtocol {
    func goToSubscribreViewController(){
        guard let controller =  storyboard.instantiateViewController(withIdentifier: "SubscribeViewController") as? SubscribeViewController else {
            return
        }
        
        let viewModel = SubscribeViewModel(coordinator: self)
        
        controller.viewModel = viewModel
        
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.pushViewController(controller, animated: true)
    }
}
