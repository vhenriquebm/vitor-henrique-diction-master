//
//  Coordinator.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 05/02/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
