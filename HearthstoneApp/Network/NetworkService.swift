//
//  NetworkService.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

class NetworkService {
    
    private let headers = [
        "X-RapidAPI-Key": "535b35baeamsh714f8ecc16c828cp1c90c0jsn0d8104b3289f",
        "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
    ]
    
    func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/\(endpoint)") else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"]) as Error
            completion(.failure(error))
            return
        }

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion(.failure(error))
                    return
                }

                completion(.success(data))
            }
        }
        task.resume()
    }
}
