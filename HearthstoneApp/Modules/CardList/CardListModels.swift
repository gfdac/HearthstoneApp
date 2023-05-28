//
//  CardListModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

enum CardListModels {
    struct Card: Decodable, Equatable {
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
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.cardId == rhs.cardId &&
                   lhs.name == rhs.name &&
                   lhs.flavor == rhs.flavor &&
                   lhs.text == rhs.text &&
                   lhs.cardSet == rhs.cardSet &&
                   lhs.type == rhs.type &&
                   lhs.faction == rhs.faction &&
                   lhs.rarity == rhs.rarity &&
                   lhs.attack == rhs.attack &&
                   lhs.cost == rhs.cost &&
                   lhs.health == rhs.health &&
                   lhs.img == rhs.img
        }
    }
    
    struct CardCategory {
        let categoryName: String
        var cards: [Card]
    }
}
