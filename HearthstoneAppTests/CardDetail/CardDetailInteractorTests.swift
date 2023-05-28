//
//  CardDetailInteractorTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 28/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardDetailInteractorTests: XCTestCase {
    var interactor: CardDetailInteractor!
    var presenterMock: CardDetailPresenterMock!
    let card = CardDetailModels.CardDetail(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")

    override func setUp() {
        super.setUp()
        presenterMock = CardDetailPresenterMock()
        interactor = CardDetailInteractor(card: card)
        interactor.presenter = presenterMock
    }

    override func tearDown() {
        presenterMock = nil
        interactor = nil
        super.tearDown()
    }

    func testPresentCardDetail() {
        // When
        interactor.presentCardDetail()

        // Then
        XCTAssertTrue(presenterMock.presentCardDetailCalled)
        XCTAssertEqual(presenterMock.presentedCard?.cardId, card.cardId)
        XCTAssertEqual(presenterMock.presentedCard?.name, card.name)
        XCTAssertEqual(presenterMock.presentedCard?.flavor, card.flavor)
        XCTAssertEqual(presenterMock.presentedCard?.text, card.text)
        XCTAssertEqual(presenterMock.presentedCard?.cardSet, card.cardSet)
        XCTAssertEqual(presenterMock.presentedCard?.type, card.type)
        XCTAssertEqual(presenterMock.presentedCard?.faction, card.faction)
        XCTAssertEqual(presenterMock.presentedCard?.rarity, card.rarity)
        XCTAssertEqual(presenterMock.presentedCard?.attack, card.attack)
        XCTAssertEqual(presenterMock.presentedCard?.cost, card.cost)
        XCTAssertEqual(presenterMock.presentedCard?.health, card.health)
        XCTAssertEqual(presenterMock.presentedCard?.img, card.img)
    }
}

// MARK: - Mocks
class CardDetailPresenterMock: CardDetailPresenterProtocol {
    var presentCardDetailCalled = false
    var presentedCard: CardDetailModels.CardDetail?

    func presentCardDetail(_ card: CardDetailModels.CardDetail) {
        presentCardDetailCalled = true
        presentedCard = card
    }

    func presentError(message: String) {
        // Not needed for this test
    }

    func viewDidLoad() {
        // Not needed for this test
    }
}
