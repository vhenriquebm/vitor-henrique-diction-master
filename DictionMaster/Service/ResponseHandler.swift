//
//  ResponseHandler.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 06/02/24.
//

import Foundation

class ResponseHandler {
    
    private init() {}
    
    static func handleResponse(with statusCode: Int, coordinator: SearchCoordinatorProtocol) {
        switch statusCode {
        case 404:
            coordinator.showError(message: ApiError.invalid_input.localizedDescription)
        case 500:
            coordinator.showError(message: ApiError.networkError.localizedDescription)
        default:
            coordinator.showError(message: ApiError.networkError.localizedDescription)
        }
    }
}
