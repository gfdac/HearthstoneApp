//
//  HearthstoneAPI.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

protocol HearthstoneAPIProtocol {
    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void)
}

class HearthstoneAPI: HearthstoneAPIProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void) {
        let endpoint = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards"
        
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode([String: [CardListModels.Card]].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


