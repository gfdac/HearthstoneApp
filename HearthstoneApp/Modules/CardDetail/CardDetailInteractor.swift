//
//  CardDetailInteractor.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardDetailInteractorProtocol {
    func presentCardDetail()
}

class CardDetailInteractor: CardDetailInteractorProtocol {
    weak var presenter: CardDetailPresenterProtocol?
    let apiService: HearthstoneAPIProtocol
    let card: CardListModels.Card
    
    init(apiService: HearthstoneAPIProtocol, card: CardListModels.Card) {
        self.apiService = apiService
        self.card = card
    }
    
    func presentCardDetail() {
        presenter?.presentCardDetail(self.card)
    }
}

