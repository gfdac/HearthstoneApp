//  CardListPresenter.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//
import Foundation

protocol CardListPresenterProtocol: AnyObject {
    func fetchCards()
    func presentCards(_ cards: [String: [CardListModels.Card]])
    func presentError(message: String)
    func selectCard(_ card: CardListModels.Card)
}

class CardListPresenter: CardListPresenterProtocol {
    weak var view: CardListViewProtocol?
    var interactor: CardListInteractorProtocol
    var router: CardListRouterProtocol?
    
    init(view: CardListViewProtocol, interactor: CardListInteractorProtocol, router: CardListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func fetchCards() {
        view?.startLoadingIndicator()
        interactor.fetchCards { [weak self] result in
            self?.view?.stopLoadingIndicator()
            switch result {
            case .success(let categories):
                self?.view?.displayCards(categories)
            case .failure(let error):
                
                self?.view?.displayError(message: error.localizedDescription)
                
            }
        }
    }
    
    
    func presentCards(_ cards: [String: [CardListModels.Card]]) {
        view?.displayCards(cards)
    }
    
    func presentError(message: String) {
        view?.displayError(message: message)
    }
    
    func selectCard(_ card: CardListModels.Card) {
        router?.navigateToCardDetail(with: card)
    }
}
