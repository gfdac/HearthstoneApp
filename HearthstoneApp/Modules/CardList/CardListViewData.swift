//
//  CardListViewData.swift
//  HearthstoneApp
//
//  Created by Guh F on 27/05/23.
//
struct CardListViewData {
    let cardId: String?
    let name: String
    let flavor: String?
    let description: String?
    let cardSet: String?
    let type: String?
    let faction: String?
    let rarity: String?
    let attack: String
    let cost: String
    let health: String
    let img: String?
    
    init(card: CardListModels.Card) {
        cardId = card.cardId
        name = card.name
        flavor = card.flavor ?? ""
        description = card.description ?? ""
        cardSet = card.cardSet ?? ""
        type = card.type ?? ""
        faction = card.faction ?? ""
        rarity = card.rarity ?? ""
        attack = card.attack != nil ? "\(card.attack!)" : ""
        cost = card.cost != nil ? "\(card.cost!)" : ""
        health = card.health != nil ? "\(card.health!)" : ""
        img = card.img ?? ""
    }
}
