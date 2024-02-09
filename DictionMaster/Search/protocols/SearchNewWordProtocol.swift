//
//  SearchNewWordProtocol.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation
import RxSwift

protocol SearchNewWordProtocol: AnyObject {
    func searchNewWord(with word: String)
    var isLoading: BehaviorSubject<Bool> { get }
}

protocol SearchNewWordServiceProtocol {
    func searchNewWord(with word: String,  completion: @escaping searchCompletion)
}
