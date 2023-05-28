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
        // Criar e configurar a tela de detalhes do cartão
//        let networkService = NetworkService()
//        let apiService = HearthstoneService(networkService: networkService)
//        _ = CardDetailInteractor(apiService: apiService, card: card)
        let presenter = CardDetailPresenter()
        let cardDetailVC = CardDetailViewController(presenter: presenter, card: card)
        presenter.card = card
        presenter.view = cardDetailVC
        
        
        // Navegar para a tela de detalhes
        viewController?.navigationController?.pushViewController(cardDetailVC, animated: true)
    }
}
