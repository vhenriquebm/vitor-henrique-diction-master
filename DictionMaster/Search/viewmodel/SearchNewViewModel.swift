//
//  SearchNewViewModel.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import Foundation
import RxSwift

class SearchNewViewModel: SearchNewWordProtocol {
    private let service: SearchNewWordServiceProtocol?
    private var coordinator: SearchCoordinatorProtocol
    private var searchResult: [SearchWordResponse]?
    
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    init(service: SearchNewWordServiceProtocol, coordinator: SearchCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func searchNewWord(with word: String) {
        let searchData = DataStorageManager.shared.readDataBase(for: word.lowercased())
        
        if !searchData.isEmpty {
            self.searchResult = searchData
            handleUserSearchDate()
            isLoading.onNext(false)
        } else {
            isLoading.onNext(true)
            service?.searchNewWord(with: word, completion: { response, status_code in
                switch response {
                case let .success(searchResult):
                    self.searchResult = searchResult
                    self.handleUserSearchDate()
                    self.isLoading.onNext(false)
                case let .failure(error):
                    ResponseHandler.handleResponse(with: status_code
                                                   , coordinator: self.coordinator)
                    self.isLoading.onNext(false)
                    
                }
            })
        }
    }
    
    private func handleUserSearchDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let newDate = formatter.string(from: date)
        
        let last_search_date = UserInfo.getSearchDate
        
        if last_search_date.isEmpty {
            UserInfo.setSearchDate(date: newDate)
            UserInfo.setSearchNumber(number: 1)
            let number_of_searchs = UserInfo.getSearchNumber
            handleNavigation(with: number_of_searchs)
        } else {
            compareDates(lastDate: last_search_date)
        }
    }
    
    private func compareDates(lastDate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        formatter.locale = Locale(identifier: "pt_BR")
        
        if let lastSearchDate = formatter.date(from: lastDate) {
            
            handleSearchNumber()
            
            if Calendar.current.isDateInToday(lastSearchDate) {
                EventLogger.logEvent(title: "User Date", message: "The last search Date is Today")
            } else {
                EventLogger.logEvent(title: "User Date", message: "The last search Date is not Today")
            }
        } else {
            EventLogger.logEvent(title: "User Date", message: "Error converting date")
        }
    }
    
    private func handleSearchNumber() {
        var number_of_searchs = UserInfo.getSearchNumber
        
        number_of_searchs += 1
        
        UserInfo.setSearchNumber(number: number_of_searchs)
        
        handleNavigation(with: number_of_searchs)
    }
    
    private func handleNavigation(with number: Int) {
        
        guard let searchResult = searchResult else { return }
        
        if number > 5 {
            self.coordinator.goToSubscribreViewController()
        } else {
            self.coordinator.goToResultViewController(with: searchResult)
        }
    }
}



