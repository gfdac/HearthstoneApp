//
//  CardListRouter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardListRouterProtocol {
    func navigateToCardDetail(with card: CardListModels.Card)
}

class CardListRouter: CardListRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToCardDetail(with card: CardListModels.Card) {
        let presenter = CardDetailPresenter()
        let cardDetailVC = CardDetailViewController(presenter: presenter, card: card)
        
        presenter.card = CardDetailModels.CardDetail(cardId: card.cardId, name: card.name, flavor: card.flavor, text: card.text, cardSet: card.cardSet, type: card.type, faction: card.faction, rarity: card.rarity, attack: card.attack, cost: card.cost, health: card.health, img: card.img)
        
        presenter.view = cardDetailVC
        
        viewController?.navigationController?.pushViewController(cardDetailVC, animated: true)
    }
}
