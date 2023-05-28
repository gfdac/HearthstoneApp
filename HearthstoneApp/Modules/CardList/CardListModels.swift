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
        let cardId: String?
        let name: String
        let flavor: String?
        let description: String?
        let cardSet: String?
        let type: String?
        let faction: String?
        let rarity: String?
        let attack: Int?
        let cost: Int?
        let health: Int?
        let img: String?
        
        // Decodable initializer
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            cardId = try container.decodeIfPresent(String.self, forKey: .cardId)
            name = try container.decode(String.self, forKey: .name)
            flavor = try container.decodeIfPresent(String.self, forKey: .flavor)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            cardSet = try container.decodeIfPresent(String.self, forKey: .cardSet)
            type = try container.decodeIfPresent(String.self, forKey: .type)
            faction = try container.decodeIfPresent(String.self, forKey: .faction)
            rarity = try container.decodeIfPresent(String.self, forKey: .rarity)
            attack = try container.decodeIfPresent(Int.self, forKey: .attack)
            cost = try container.decodeIfPresent(Int.self, forKey: .cost)
            health = try container.decodeIfPresent(Int.self, forKey: .health)
            //TODO: trocar essa imagem por alguma default
            img = try container.decodeIfPresent(String.self, forKey: .image) ?? "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/18dcfec72ef2dec44217aea899c22c2f77f8e86ae64d38b53caaffd668888adb.png"
        }
        
        private enum CodingKeys: String, CodingKey {
            case cardId
            case name
            case flavor
            case description
            case cardSet
            case type
            case faction
            case rarity
            case attack
            case cost
            case health
            case image
        }
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
               lhs.img == rhs.img
    }
}
