//
//  CardDetailPresenterTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 28/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardDetailPresenterTests: XCTestCase {
    var presenter: CardDetailPresenter!
    var viewMock: CardDetailViewMock!

    override func setUp() {
        super.setUp()
        viewMock = CardDetailViewMock()
        presenter = CardDetailPresenter()
        presenter.view = viewMock
    }

    override func tearDown() {
        viewMock = nil
        presenter = nil
        super.tearDown()
    }

    func testPresentCardDetail() {
        // Given
        let card = CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")

        // When
        presenter.presentCardDetail(card)

        // Then
        XCTAssertTrue(viewMock.displayCardDetailCalled)
        XCTAssertEqual(viewMock.displayedCard, card)
    }

    func testPresentError() {
        // Given
        let errorMessage = "An error occurred"

        // When
        presenter.presentError(message: errorMessage)

        // Then
        XCTAssertTrue(viewMock.displayErrorCalled)
        XCTAssertEqual(viewMock.errorMessage, errorMessage)
    }

    func testViewDidLoadWithCard() {
        // Given
        let card = CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")
        presenter.card = card

        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(viewMock.displayCardDetailCalled)
        XCTAssertEqual(viewMock.displayedCard, card)
    }

    func testViewDidLoadWithoutCard() {
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssertTrue(viewMock.displayErrorCalled)
        XCTAssertEqual(viewMock.errorMessage, "Card not found")
    }
}

// MARK: - Mocks
class CardDetailViewMock: CardDetailViewProtocol {
    var displayCardDetailCalled = false
    var displayedCard: CardListModels.Card?
    var displayErrorCalled = false
    var errorMessage: String?

    func displayCardDetail(_ card: CardListModels.Card) {
        displayCardDetailCalled = true
        displayedCard = card
    }

    func displayError(message: String) {
        displayErrorCalled = true
        errorMessage = message
    }
}

