//
//  CardListPresenter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardListPresenterProtocol: AnyObject {
    func fetchCards()
    func presentCards(_ cards: [CardListModels.Card])
    func presentError(message: String)
}

class CardListPresenter: CardListPresenterProtocol {
    weak var view: CardListViewProtocol?
    var interactor: CardListInteractorProtocol
    
    init(interactor: CardListInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetchCards() {
        interactor.fetchCards()
    }
    
    func presentCards(_ cards: [CardListModels.Card]) {
        view?.displayCards(cards)
    }
    
    func presentError(message: String) {
        view?.displayError(message: message)
    }
}

