//
//  SearchCoordinatorProtocol.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import Foundation

protocol SearchCoordinatorProtocol: Coordinator {
    func goToResultViewController(with searchResponse:[SearchWordResponse])
    
    func goToSubscribreViewController()
    
    func showError(message: String)
}
