//
//  EventLogger.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation

class EventLogger {
    
    static func log <T>( path: String,
                         statusCode: Int,
                         headers: Dictionary<String, Any> = [:] ,
                         error: String = "Sucesso em solicitar os dados",
                         params: Dictionary<String, Any> = [:],
                         response: HTTPURLResponse?,
                         responseValue: T? = "" )  {
        
        let log_dictionary: [String: Any] = [
            "path": path,
            "status code": statusCode,
            "headers": headers,
            "message": error,
            "params": params,
            "response": response ?? "",
            "responseValue": responseValue ?? ""
        ]
        
        print (log_dictionary)
    }
    
    static func logEvent(title: String, message: String) {
        let log = ["title": title,
                   "message": message
        ]
        print (log)
    }
}
