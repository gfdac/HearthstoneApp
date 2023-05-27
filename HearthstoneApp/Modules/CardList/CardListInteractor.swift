//
//  CardListInteractor.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardListInteractorProtocol {
    func fetchCards()
}

class CardListInteractor: CardListInteractorProtocol {
    weak var presenter: CardListPresenterProtocol?
    let apiService: HearthstoneAPIProtocol
    
    init(apiService: HearthstoneAPIProtocol) {
        self.apiService = apiService
    }
    
    func fetchCards() {
        apiService.getAllCards { [weak self] result in
            switch result {
            case .success(let cards):
                self?.presenter?.presentCards(cards)
            case .failure(let error):
                self?.presenter?.presentError(message: error.localizedDescription)
            }
        }
    }
}

