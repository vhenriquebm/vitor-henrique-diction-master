//
//  Alert.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit

extension UIViewController {
    func showError(message: String) {
        let controller = UIAlertController(title: "Erro na busca", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        controller.addAction(action)
        present(controller, animated: true)
    }
}



