//
//  CardDetailRouter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import UIKit

protocol CardDetailRouterProtocol {
    static func createModule(with card: CardListModels.Card) -> UIViewController
}

class CardDetailRouter: CardDetailRouterProtocol {
    static func createModule(with card: CardListModels.Card) -> UIViewController {
        let presenter = CardDetailPresenter()
        let view = CardDetailViewController(presenter: presenter, card: card)
        
        presenter.view = view

        return view
    }
}
