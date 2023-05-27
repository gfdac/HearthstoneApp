//
//  CardListInteractorTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 27/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardListInteractorTests: XCTestCase {
    var interactor: CardListInteractor!
    var presenterMock: CardListPresenterMock!
    var apiServiceMock: HearthstoneAPIMock!

    override func setUp() {
        super.setUp()
        presenterMock = CardListPresenterMock()
        apiServiceMock = HearthstoneAPIMock()
        interactor = CardListInteractor(apiService: apiServiceMock)
        interactor.presenter = presenterMock
    }

    override func tearDown() {
        presenterMock = nil
        apiServiceMock = nil
        interactor = nil
        super.tearDown()
    }

    func testFetchCards_Success() {
        // Given
        let expectedCards = [
            CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", description: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, image: "Image 1"),
            CardListModels.Card(cardId: "cardId2", name: "Card 2", flavor: "Flavor 2", description: "Description 2", cardSet: "Set 2", type: "Type 2", faction: "Faction 2", rarity: "Rarity 2", attack: 2, cost: 2, health: 2, image: "Image 2")
        ]
        apiServiceMock.getAllCardsCompletionResult = .success(["Basic": expectedCards])
        
        // When
        interactor.fetchCards()
        
        // Then
        XCTAssertTrue(apiServiceMock.getAllCardsCalled)
        XCTAssertTrue(presenterMock.presentCardsCalled)
        XCTAssertEqual(presenterMock.presentedCards, expectedCards)
        XCTAssertFalse(presenterMock.presentErrorCalled)
    }

    func testFetchCards_Failure() {
        // Given
        let expectedError = NSError(domain: "HearthstoneAPIError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        apiServiceMock.getAllCardsCompletionResult = .failure(expectedError)
        
        // When
        interactor.fetchCards()
        
        // Then
        XCTAssertTrue(apiServiceMock.getAllCardsCalled)
        XCTAssertFalse(presenterMock.presentCardsCalled)
        XCTAssertTrue(presenterMock.presentErrorCalled)
        XCTAssertEqual(presenterMock.presentedErrorMessage, expectedError.localizedDescription)
    }
}

// MARK: - Mocks

class CardListPresenterMock: CardListPresenterProtocol {
    var fetchCardsCalled = false
    var presentCardsCalled = false
    var presentedCards: [CardListModels.Card] = []
    var presentErrorCalled = false
    var presentedErrorMessage = ""

    func fetchCards() {
        fetchCardsCalled = true
    }

    func presentCards(_ cards: [CardListModels.Card]) {
        presentCardsCalled = true
        presentedCards = cards
    }

    func presentError(message: String) {
        presentErrorCalled = true
        presentedErrorMessage = message
    }
}


class HearthstoneAPIMock: HearthstoneAPIProtocol {
    var getAllCardsCalled = false
    var getAllCardsCompletionResult: Result<[String: [CardListModels.Card]], Error>?

    func getAllCards(completion: @escaping (Result<[String: [CardListModels.Card]], Error>) -> Void) {
        getAllCardsCalled = true
        if let result = getAllCardsCompletionResult {
            completion(result)
        }
    }
}
