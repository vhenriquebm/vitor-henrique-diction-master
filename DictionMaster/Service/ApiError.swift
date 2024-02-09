//
//  ApiError.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 09/02/24.
//

import Foundation

enum ApiError: Error {
    case networkError
    case invalid_input
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Desculpe, estamos enfrentando um problema temporário. Por favor, tente novamente em breve."
        case .invalid_input:
            return  "Desculpe, não conseguimos encontrar uma tradução para a palavra que você digitou. Por favor, verifique a ortografia e tente novamente, ou tente outra palavra."
        }
    }
}
