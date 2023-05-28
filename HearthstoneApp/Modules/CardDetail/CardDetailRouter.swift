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
        let view = CardDetailViewController()
        let interactor = CardDetailInteractor(apiService: HearthstoneAPIService(), card: card)
        let presenter = CardDetailPresenter()
        let router = CardDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}

