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
    let card: CardDetailModels.CardDetail
    
    init(card: CardDetailModels.CardDetail) {
        self.card = card
    }
    
    func presentCardDetail() {
        presenter?.presentCardDetail(self.card)
    }
}

