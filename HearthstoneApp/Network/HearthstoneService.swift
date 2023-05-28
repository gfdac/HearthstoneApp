//
//  HearthstoneAPI.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

//protocol HearthstoneAPIProtocol {
////    func getAllCards(completion: @escaping (Result<[CardListModels.Card], Error>) -> Void)
//    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void)
//    func getCardDetail(cardId: String, completion: @escaping (Result<CardDetailModels.CardDetail, Error>) -> Void)
//}


protocol HearthstoneAPIProtocol {
    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void)
    func getCardDetail(cardId: String, completion: @escaping (Result<CardDetailModels.CardDetail, Error>) -> Void)
}


class HearthstoneService: HearthstoneAPIProtocol {
    private let baseURL = "https://omgvamp-hearthstone-v1.p.rapidapi.com"
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private func buildRequest(urlPath: String) -> URLRequest {
        let url = URL(string: baseURL + urlPath)!
        var request = URLRequest(url: url)
        request.addValue("535b35baeamsh714f8ecc16c828cp1c90c0jsn0d8104b3289f", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("omgvamp-hearthstone-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        return request
    }
    
//    func getAllCards(completion: @escaping (Result<[CardListModels.Card], Error>) -> Void) {
//        let urlPath = "/cards"
//        let request = buildRequest(urlPath: urlPath)
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(HearthstoneAPIError.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let cards = try decoder.decode([CardListModels.Card].self, from: data)
//                completion(.success(cards))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
    
    
    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void) {
        let urlPath = "/cards"
        let request = buildRequest(urlPath: urlPath)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(HearthstoneAPIError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Adicionado para converter as chaves para camelCase
                let cardsDictionary = try decoder.decode([String: [CardListModels.Card]].self, from: data)
                completion(.success(cardsDictionary))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    
    
    
    
    func getCardDetail(cardId: String, completion: @escaping (Result<CardDetailModels.CardDetail, Error>) -> Void) {
        let urlPath = "/cards/\(cardId)"
        let request = buildRequest(urlPath: urlPath)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(HearthstoneAPIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cardDetail = try decoder.decode(CardDetailModels.CardDetail.self, from: data)
                completion(.success(cardDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum HearthstoneAPIError: Error {
    case invalidData
}
