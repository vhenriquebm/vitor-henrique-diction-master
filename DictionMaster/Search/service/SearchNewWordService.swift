//
//  SearchNewWordService.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation
import Alamofire

typealias searchCompletion = (Result <[SearchWordResponse], Error>) -> Void


class SearchNewWordService: SearchNewWordServiceProtocol {
    
    let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    public func searchNewWord(with word: String,  completion: @escaping searchCompletion) {
        let url = urlString + word
        
        AF.request(url, method: .get).validate().responseDecodable(of: [SearchWordResponse].self) { response in
            
            let status_code = response.response?.statusCode ?? 0
            
            switch response.result {
            case let .success(searchResponse):
                completion(.success(searchResponse))
                EventLogger.log(path: url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                response: response.response,
                                responseValue: searchResponse)
            case let .failure(error):
                completion(.failure(error))
                EventLogger.log(path: url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                error: error.localizedDescription,
                                response: response.response,
                                responseValue: error)
            }
        }
    }
}
