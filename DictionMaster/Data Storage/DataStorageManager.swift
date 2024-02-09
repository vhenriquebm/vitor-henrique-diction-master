//
//  DataStorageManager.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 07/02/24.
//

import UIKit
import CoreData

class DataStorageManager {
    
    static let shared = DataStorageManager()
    
    private init() {}
    
    func setDataBase(with data: [SearchWordResponse]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for searchWordResponseData in data {
            let searchWordResponseEntity = NSEntityDescription.insertNewObject(forEntityName: "SearchWordResponseEntity", into: context) as! SearchWordResponseEntity
            searchWordResponseEntity.word = searchWordResponseData.word
            searchWordResponseEntity.phonetic = searchWordResponseData.phonetic
            
            for phonetic in searchWordResponseData.phonetics {
                let phoneticEntity = NSEntityDescription.insertNewObject(forEntityName: "PhoneticsEntity", into: context) as! PhoneticsEntity
                phoneticEntity.text = phonetic.text
                phoneticEntity.audio = phonetic.audio
                searchWordResponseEntity.addToPhonetics(phoneticEntity)
            }
            
            for meaning in searchWordResponseData.meanings {
                let meaningEntity = NSEntityDescription.insertNewObject(forEntityName: "MeaningEntity", into: context) as! MeaningEntity
                meaningEntity.partOfSpeech = meaning.partOfSpeech
                
                for definition in meaning.definitions {
                    let definitionEntity = NSEntityDescription.insertNewObject(forEntityName: "DefinitionEntity", into: context) as! DefinitionEntity
                    definitionEntity.definition = definition.definition
                    definitionEntity.example = definition.example
                    meaningEntity.addToDefinitions(definitionEntity)
                }
                
                meaningEntity.searchWordResponse = searchWordResponseEntity
                searchWordResponseEntity.addToMeanings(meaningEntity)
            }
        }
        
        do {
            try context.save()
            EventLogger.logEvent(title: "Data base Manager", message: "Data saved successfully")
        } catch {
            EventLogger.logEvent(title: "Data base Manager", message: "Error saving data to database: \(error.localizedDescription)")
        }
    }
}

extension DataStorageManager {
    func readDataBase(for word: String) -> [SearchWordResponse] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<SearchWordResponseEntity> = SearchWordResponseEntity.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "word == %@", word)
            
            let searchWordResponses = try context.fetch(fetchRequest)
            
            var searchWordResponseList: [SearchWordResponse] = []
            
            for searchWordResponseEntity in searchWordResponses {
                let searchWordResponse = SearchWordResponse(
                    word: searchWordResponseEntity.word ?? "",
                    phonetic: searchWordResponseEntity.phonetic ?? "",
                    phonetics: searchWordResponseEntity.phonetics?.compactMap { ($0 as? PhoneticsEntity).map { Phonetics(text: $0.text ?? "", audio: $0.audio ?? "") } } ?? [],
                    meanings: searchWordResponseEntity.meanings?.compactMap { meaningEntity in
                        guard let meaning = meaningEntity as? MeaningEntity else { return Meaning(partOfSpeech: "", definitions: [Definition(definition: "", example: "")]) }
                        let definitions: [Definition] = meaning.definitions?.compactMap { definitionEntity -> Definition? in
                            guard let definition = definitionEntity as? DefinitionEntity else { return nil }
                            let definitionText = definition.definition ?? ""
                            let exampleText = definition.example ?? ""
                            return Definition(definition: definitionText, example: exampleText)
                        } ?? []
                        return Meaning(partOfSpeech: meaning.partOfSpeech ?? "", definitions: definitions)
                    } ?? []
                )
                searchWordResponseList.append(searchWordResponse)
            }
            
            return searchWordResponseList
        } catch {
            EventLogger.logEvent(title: "Data base Manager", message: "It was not possible to read the data from Data Base: \(error.localizedDescription)")
            return []
        }
    }
}





