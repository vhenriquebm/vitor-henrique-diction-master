//
//  UserInfo.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 06/02/24.
//

import Foundation

class UserInfo {
    static let userDefaults = UserDefaults.standard
    
    private init () {}
    
    static var getSearchDate: String {
        return userDefaults.string(forKey: "search_date") ?? ""
    }
    
    static func setSearchDate( date: String){
        return userDefaults.set(date, forKey: "search_date")
    }
    
    static var getSearchNumber: Int {
        return userDefaults.integer(forKey: "search_number")
    }
    
    static func setSearchNumber(number: Int){
        return userDefaults.set(number, forKey: "search_number")
    }
}

