//
//  ResultViewModelProtocol.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 08/02/24.
//

import Foundation

protocol ResultViewModelProtocol {
    func dismiss()
    var getResult: [SearchWordResponse] { get }
}
