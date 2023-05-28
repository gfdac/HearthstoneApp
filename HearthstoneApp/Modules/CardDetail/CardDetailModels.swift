//
//  CardDetailModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

import Foundation

enum CardDetailModels {
    // Model para representar os detalhes de um cartão
    struct CardDetails {
        let cardId: String
        let name: String
        let flavor: String
        let description: String
        let cardSet: String
        let type: String
        let faction: String
        let rarity: String
        let attack: Int
        let cost: Int
        let health: Int
        let image: String
    }
    
    struct Error {
        let message: String
    }
    
}
