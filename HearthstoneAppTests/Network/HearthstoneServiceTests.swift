//
//  MockNetworkService.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 27/05/23.
//
import XCTest
@testable import HearthstoneApp

class HearthstoneServiceTests: XCTestCase {
    var sut: HearthstoneService!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = HearthstoneService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testGetAllCardsReturnsCards() {
        let jsonString = """
        {
            "Basic": [
                {
                    "cardId": "cardId1",
                    "name": "Card 1",
                    "flavor": "Flavor 1",
                    "text": "Description 1",
                    "cardSet": "Set 1",
                    "type": "Type 1",
                    "faction": "Faction 1",
                    "rarity": "Rarity 1",
                    "attack": 1,
                    "cost": 1,
                    "health": 1,
                    "img": "Image 1"
                },
                {
                    "cardId": "cardId2",
                    "name": "Card 2",
                    "flavor": "Flavor 2",
                    "text": "Description 2",
                    "cardSet": "Set 2",
                    "type": "Type 2",
                    "faction": "Faction 2",
                    "rarity": "Rarity 2",
                    "attack": 2,
                    "cost": 2,
                    "health": 2,
                    "img": "Image 2"
                }
            ],
            "Classic": [],
            "Hall of Fame": []
        }
        """
        let mockData = jsonString.data(using: .utf8)
        mockNetworkService.mockData = mockData
        mockNetworkService.expectedEndpoint = "https://api.hearthstone.com/cards"

        sut.getAllCards { result in
            switch result {
            case .success(let cards):
                let basicCards = cards["Basic"]
                XCTAssertNotNil(basicCards)
                XCTAssertEqual(basicCards?.count, 2)

                let card1 = basicCards?[0]
                XCTAssertEqual(card1?.cardId, "cardId1")
                XCTAssertEqual(card1?.name, "Card 1")
                XCTAssertEqual(card1?.flavor, "Flavor 1")
                XCTAssertEqual(card1?.text, "Description 1")
                XCTAssertEqual(card1?.cardSet, "Set 1")
                XCTAssertEqual(card1?.type, "Type 1")
                XCTAssertEqual(card1?.faction, "Faction 1")
                XCTAssertEqual(card1?.rarity, "Rarity 1")
                XCTAssertEqual(card1?.attack, 1)
                XCTAssertEqual(card1?.cost, 1)
                XCTAssertEqual(card1?.health, 1)
                XCTAssertEqual(card1?.img, "Image 1")

                let card2 = basicCards?[1]
                XCTAssertEqual(card2?.cardId, "cardId2")
                XCTAssertEqual(card2?.name, "Card 2")
                XCTAssertEqual(card2?.flavor, "Flavor 2")
                XCTAssertEqual(card2?.text, "Description 2")
                XCTAssertEqual(card2?.cardSet, "Set 2")
                XCTAssertEqual(card2?.type, "Type 2")
                XCTAssertEqual(card2?.faction, "Faction 2")
                XCTAssertEqual(card2?.rarity, "Rarity 2")
                XCTAssertEqual(card2?.attack, 2)
                XCTAssertEqual(card2?.cost, 2)
                XCTAssertEqual(card2?.health, 2)
                XCTAssertEqual(card2?.img, "Image 2")

            case .failure(let error):
                XCTFail("Error should not occur: \(error)")
            }
        }
    }

    func testGetAllCardsReturnsErrorWhenAPIFails() {
        let error = NSError(domain: "", code: 400, userInfo: nil)
        mockNetworkService.mockError = error

        let expectation = XCTestExpectation(description: "API failure")
        expectation.isInverted = true

        sut.getAllCards { result in
            switch result {
            case .success(_):
                XCTFail("Success should not occur")
            case .failure(let error as NSError):
                XCTAssertEqual(error.code, 400)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }


}


class MockNetworkService: NetworkService {
    var mockData: Data?
    var mockError: Error?
    var expectedEndpoint: String?
    
    override func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let expectedEndpoint = expectedEndpoint, endpoint == expectedEndpoint {
            if let mockData = mockData {
                completion(.success(mockData))
            } else if let mockError = mockError {
                completion(.failure(mockError))
            }
        }
    }
}
