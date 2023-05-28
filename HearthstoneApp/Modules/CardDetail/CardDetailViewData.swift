//
//  CardDetailViewData.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//

import Foundation

struct CardDetailViewData {
    let cardId: String
    let image: String
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
    
    init(card: CardListModels.Card) {
        self.cardId = card.cardId ?? ""
        self.image = card.img ?? ""
        self.name = card.name
        self.flavor = card.flavor ?? ""
        self.description = card.text ?? ""
        self.cardSet = card.cardSet ?? ""
        self.type = card.type ?? ""
        self.faction = card.faction ?? ""
        self.rarity = card.rarity ?? ""
        self.attack = card.attack ?? 0
        self.cost = card.cost ?? 0
        self.health = card.health ?? 0
    }
}

