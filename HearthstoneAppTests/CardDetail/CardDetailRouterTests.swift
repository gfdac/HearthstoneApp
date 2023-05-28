//
//  CardDetailRouterTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 28/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardDetailRouterTests: XCTestCase {
    var router: CardDetailRouter!

    override func setUp() {
        super.setUp()
        router = CardDetailRouter()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testCreateModule() {
        // Given
        let card = CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")

        // When
        let viewController = CardDetailRouter.createModule(with: card)

        // Then
        XCTAssertTrue(viewController is CardDetailViewController)
    }
}
