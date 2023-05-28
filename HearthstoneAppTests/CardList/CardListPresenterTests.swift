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
    var interactorMock: CardListInteractorMock!
    var routerMock: CardListRouterMock!

    override func setUp() {
        super.setUp()
        viewMock = CardListViewMock()
        interactorMock = CardListInteractorMock()
        routerMock = CardListRouterMock()
        presenter = CardListPresenter(view: viewMock, interactor: interactorMock, router: routerMock)
    }

    override func tearDown() {
        viewMock = nil
        interactorMock = nil
        routerMock = nil
        presenter = nil
        super.tearDown()
    }

    func testFetchCards() {
        // When
        presenter.fetchCards()

        // Then
        XCTAssertTrue(viewMock.startLoadingIndicatorCalled)
        XCTAssertTrue(interactorMock.fetchCardsCompletionCalled)
    }

    func testPresentCards() {
        // Given
        let cards = [
            "Section 1": [
                CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Text 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1"),
                CardListModels.Card(cardId: "cardId2", name: "Card 2", flavor: "Flavor 2", text: "Text 2", cardSet: "Set 2", type: "Type 2", faction: "Faction 2", rarity: "Rarity 2", attack: 2, cost: 2, health: 2, img: "Image 2")
            ],
            "Section 2": [
                CardListModels.Card(cardId: "cardId3", name: "Card 3", flavor: "Flavor 3", text: "Text 3", cardSet: "Set 3", type: "Type 3", faction: "Faction 3", rarity: "Rarity 3", attack: 3, cost: 3, health: 3, img: "Image 3"),
                CardListModels.Card(cardId: "cardId4", name: "Card 4", flavor: "Flavor 4", text: "Text 4", cardSet: "Set 4", type: "Type 4", faction: "Faction 4", rarity: "Rarity 4", attack: 4, cost: 4, health: 4, img: "Image 4")
            ]
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

    func testSelectCard() {
        // Given
        let card = CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Text 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")

        // When
        presenter.selectCard(card)

        // Then
        XCTAssertTrue(routerMock.navigateToCardDetailCalled)
        XCTAssertEqual(routerMock.selectedCard, card)
    }
}

// MARK: - Mocks

class CardListViewMock: CardListViewProtocol {
    var displayCardsCalled = false
    var displayedCards: [String: [CardListModels.Card]] = [:]
    var displayErrorCalled = false
    var displayedErrorMessage = ""
    var startLoadingIndicatorCalled = false
    var stopLoadingIndicatorCalled = false
    var navigateToCardDetailCalled = false
    var selectedCard: CardListModels.Card?

    func displayCards(_ cards: [String: [CardListModels.Card]]) {
        displayCardsCalled = true
        displayedCards = cards
    }

    func displayError(message: String) {
        displayErrorCalled = true
        displayedErrorMessage = message
    }

    func startLoadingIndicator() {
        startLoadingIndicatorCalled = true
    }

    func stopLoadingIndicator() {
        stopLoadingIndicatorCalled = true
    }

    func navigateToCardDetail(card: CardListModels.Card) {
        navigateToCardDetailCalled = true
        selectedCard = card
    }
}

class CardListInteractorMock: CardListInteractorProtocol {
    weak var presenter: CardListPresenterProtocol?
    private(set) var fetchCardsCompletionCalled = false

    func fetchCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void) {
        fetchCardsCompletionCalled = true
    }
}

class CardListRouterMock: CardListRouterProtocol {
    var navigateToCardDetailCalled = false
    var selectedCard: CardListModels.Card?

    func navigateToCardDetail(with card: CardListModels.Card) {
        navigateToCardDetailCalled = true
        selectedCard = card
    }
}
