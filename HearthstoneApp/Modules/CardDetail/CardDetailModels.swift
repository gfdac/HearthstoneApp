//
//  CardDetailModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

//  CardDetailModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

enum CardDetailModels {
    // Model para representar os detalhes de um cartão
    struct CardDetail: Decodable, Equatable {
        let cardId: String?
        let name: String
        let flavor: String?
        let text: String?
        let cardSet: String?
        let type: String?
        let faction: String?
        let rarity: String?
        let attack: Int?
        let cost: Int?
        let health: Int?
        let img: String?
    }
    
    struct Error {
        let message: String
    }
    
}
