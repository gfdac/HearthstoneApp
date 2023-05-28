//  CardListInteractor.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol CardListInteractorProtocol {
    func fetchCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void)
}

class CardListInteractor: CardListInteractorProtocol {
    weak var presenter: CardListPresenterProtocol?
    let apiService: HearthstoneAPIProtocol
    
    init(apiService: HearthstoneAPIProtocol) {
        self.apiService = apiService
    }
    
    func fetchCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void) {
        apiService.getAllCards { result in
            switch result {
            case .success(let categories):
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCards() {
        apiService.getAllCards { [weak self] result in
            switch result {
            case .success(let categories):
                self?.presenter?.presentCards(categories)
            case .failure(let error):
                self?.presenter?.presentError(message: error.localizedDescription)
            }
        }
    }
}
