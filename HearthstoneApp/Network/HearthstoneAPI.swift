//
//  HearthstoneAPI.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

class HearthstoneAPI {
    private let networkService = NetworkService()
    private let decoder = JSONDecoder()
    
    func getAllCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        networkService.request(endpoint: "cards") { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let cards = try self?.decoder.decode([Card].self, from: data)
                    completion(.success(cards ?? []))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

