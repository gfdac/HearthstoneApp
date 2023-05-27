//
//  CardListPresenterTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 27/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardListPresenterTests: XCTestCase {
    var presenter: CardListPresenter!
    var viewMock: CardListViewMock!

    override func setUp() {
        super.setUp()
        viewMock = CardListViewMock()
        presenter = CardListPresenter(interactor: CardListInteractor(apiService: HearthstoneAPIMock()))
        presenter.view = viewMock
    }

    override func tearDown() {
        viewMock = nil
        presenter = nil
        super.tearDown()
    }

    func testPresentCards() {
        // Given
        let cards = [
            CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", description: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, image: "Image 1"),
            CardListModels.Card(cardId: "cardId2", name: "Card 2", flavor: "Flavor 2", description: "Description 2", cardSet: "Set 2", type: "Type 2", faction: "Faction 2", rarity: "Rarity 2", attack: 2, cost: 2, health: 2, image: "Image 2")
        ]

        // When
        presenter.presentCards(cards)

        // Then
        XCTAssertTrue(viewMock.displayCardsCalled)
        XCTAssertEqual(viewMock.displayedCards, cards)
        XCTAssertFalse(viewMock.displayErrorCalled)
    }

    func testPresentError() {
        // Given
        let errorMessage = "An error occurred"

        // When
        presenter.presentError(message: errorMessage)

        // Then
        XCTAssertFalse(viewMock.displayCardsCalled)
        XCTAssertTrue(viewMock.displayErrorCalled)
        XCTAssertEqual(viewMock.displayedErrorMessage, errorMessage)
    }
}

// MARK: - Mocks

class CardListViewMock: CardListViewProtocol {
    var displayCardsCalled = false
    var displayedCards: [CardListModels.Card] = []
    var displayErrorCalled = false
    var displayedErrorMessage = ""

    func displayCards(_ cards: [CardListModels.Card]) {
        displayCardsCalled = true
        displayedCards = cards
    }

    func displayError(message: String) {
        displayErrorCalled = true
        displayedErrorMessage = message
    }
}
