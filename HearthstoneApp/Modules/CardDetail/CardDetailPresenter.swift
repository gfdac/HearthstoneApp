//
//  CardDetailPresenter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardDetailPresenterProtocol: AnyObject {
//    func presentCardDetail(_ cardDetail: CardDetailModels.CardDetail)
    func presentError(message: String)
    func viewDidLoad()
}

class CardDetailPresenter: CardDetailPresenterProtocol {

    weak var view: CardDetailViewProtocol?
    var interactor: CardDetailInteractorProtocol?
    var card: CardListModels.Card?

//    func presentCardDetail(_ cardDetail: CardDetailModels.CardDetail) {
//        let viewData = CardDetailViewData(card: cardDetail)
//        view?.displayCardDetail(viewData)
//    }

    func presentError(message: String) {
        view?.displayError(message: message)
    }

    func viewDidLoad() {
        guard let card = card else {
            presentError(message: "Card not found")
            return
        }
        interactor?.fetchCardDetail()
    }
}



//extension CardDetailPresenter: CardDetailInteractorOutputProtocol {
//    func presentCardDetail(_ cardDetail: CardDetailModels.CardDetail) {
//        view?.displayCardDetail(cardDetail)
//    }
//
//    func presentError(message: String) {
//        view?.displayError(message: message)
//    }
//}

