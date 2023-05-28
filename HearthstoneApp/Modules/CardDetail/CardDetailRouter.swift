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
        let networkService = NetworkService() 
        let apiService = HearthstoneService(networkService: networkService)
        let interactor = CardDetailInteractor(apiService: apiService, card: card)
        let presenter = CardDetailPresenter()
        let router = CardDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
