//
//  SearchWordResponse.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation

struct SearchWordResponse: Codable {
    let word, phonetic: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition, example: String?
//        let synonyms, antonyms: [JSONAny]
}

struct Phonetic: Codable {
    let text: String?
    let audio: String?
}
