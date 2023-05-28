//
//  CardDetailInteractor.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardDetailInteractorProtocol {
    func fetchCardDetail()
}

class CardDetailInteractor: CardDetailInteractorProtocol {
    weak var presenter: CardDetailPresenterProtocol?
    let apiService: HearthstoneAPIProtocol
    let card: CardListModels.Card
    
    init(apiService: HearthstoneAPIProtocol, card: CardListModels.Card) {
        self.apiService = apiService
        self.card = card
    }
    
    func fetchCardDetail() {
        // Use a API do Hearthstone para buscar os detalhes do cartão usando o cardId
//        apiService.getCardDetail(cardId: card.cardId) { [weak self] result in
//            switch result {
//            case .success(let cardDetail):
//                print("sucesso")
//                //self?.presenter?.presentCardDetail(cardDetail)
//            case .failure(let error):
//                self?.presenter?.presentError(message: error.localizedDescription)
//            }
//        }
    }
}

