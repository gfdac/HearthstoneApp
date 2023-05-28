//
//  CardDetailPresenter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardDetailPresenterProtocol: AnyObject {
    //TODO: os models aqui deveriam ser outros, mas ta..
    func presentCardDetail(_ cardDetail: CardListModels.Card)
    func presentError(message: String)
    func viewDidLoad()
}

class CardDetailPresenter: CardDetailPresenterProtocol {

    weak var view: CardDetailViewProtocol?
    var card: CardListModels.Card?

    func presentCardDetail(_ card: CardListModels.Card) {
        view?.displayCardDetail(card)
    }

    func presentError(message: String) {
        view?.displayError(message: message)
    }

    func viewDidLoad() {
        guard let card = card else {
            presentError(message: "Card not found")
            return
        }
        
        view?.displayCardDetail(card)
    }
}
