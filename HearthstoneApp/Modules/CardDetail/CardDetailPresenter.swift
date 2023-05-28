//
//  CardDetailPresenter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardDetailPresenterProtocol: AnyObject {
    func presentCardDetail(_ cardDetail: CardDetailModels.CardDetail)
    func presentError(message: String)
    func viewDidLoad()
}

class CardDetailPresenter: CardDetailPresenterProtocol {

    weak var view: CardDetailViewProtocol?
    var card: CardDetailModels.CardDetail?

    func presentCardDetail(_ card: CardDetailModels.CardDetail) {
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
