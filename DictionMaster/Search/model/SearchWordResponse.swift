//
//  SearchWordResponse.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation

public struct SearchWordResponse: Codable {
    let word, phonetic: String?
    let phonetics: [Phonetics]
    let meanings: [Meaning]
}

@objc(Phonetics)
public class Phonetics: NSObject, Codable {
    @objc var text: String?
    @objc var audio: String?
    
    init(text: String?, audio: String?) {
        self.text = text
        self.audio = audio
    }
}

@objc(Meaning)
public class Meaning: NSObject, Codable {
    @objc var partOfSpeech: String
    @objc var definitions: [Definition]
    
    init(partOfSpeech: String, definitions: [Definition]) {
        self.partOfSpeech = partOfSpeech
        self.definitions = definitions
    }
}

@objc(Definition)
class Definition: NSObject, Codable {
    @objc var definition: String
    @objc var example: String?
    
    init(definition: String, example: String?) {
        self.definition = definition
        self.example = example
    }
}


