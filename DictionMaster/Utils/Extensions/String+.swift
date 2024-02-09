//
//  String+.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 09/02/24.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        guard let first = self.first else {
            return self
        }
        return String(first).uppercased() + self.dropFirst()
    }
}

extension String {
    func lowercaseString() -> String {
        return self.lowercased()
    }
}



