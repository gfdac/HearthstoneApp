//
//  CardListModels.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

enum CardListModels {
    // Model para representar um card
    struct Card {
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
    }
    
    // Model para representar uma categoria de cards
    struct CardCategory {
        let categoryName: String
        var cards: [Card]
    }
}
