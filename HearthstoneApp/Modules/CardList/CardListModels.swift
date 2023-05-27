//
//  CardListModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

enum CardListModels {
    // Model para representar um card
    struct Card: Decodable {
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
    
    // Model para representar uma categoria de cards
    struct CardCategory {
        let categoryName: String
        var cards: [Card]
    }
}

extension CardListModels.Card: Equatable {
    static func == (lhs: CardListModels.Card, rhs: CardListModels.Card) -> Bool {
        return lhs.cardId == rhs.cardId &&
               lhs.name == rhs.name &&
               lhs.flavor == rhs.flavor &&
               lhs.description == rhs.description &&
               lhs.cardSet == rhs.cardSet &&
               lhs.type == rhs.type &&
               lhs.faction == rhs.faction &&
               lhs.rarity == rhs.rarity &&
               lhs.attack == rhs.attack &&
               lhs.cost == rhs.cost &&
               lhs.health == rhs.health &&
               lhs.image == rhs.image
    }
}
