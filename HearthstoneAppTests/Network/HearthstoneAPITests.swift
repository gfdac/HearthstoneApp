//
//  HearthstoneAPITests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 27/05/23.
//

import XCTest
@testable import HearthstoneApp

class MockNetworkService: NetworkService {
    var mockData: Data?
    var mockError: Error?
    
    override func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let mockData = mockData {
            completion(.success(mockData))
        } else if let mockError = mockError {
            completion(.failure(mockError))
        }
    }
}

class HearthstoneAPITests: XCTestCase {
    var sut: HearthstoneAPI!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = HearthstoneAPI(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testGetAllCardsReturnsCards() {
        // Mock JSON response from the Hearthstone API
        let jsonString = """
        {
            "Basic": [
                {
                    "cardId": "RLK_Prologue_CS2_092e",
                    "dbfId": 100672,
                    "name": "Blessing of Kings",
                    "flavor": "Give a minion +4/+4. (+4 Attack/+4 Health)",
                    "description": "Short description",
                    "cardSet": "Basic",
                    "type": "Enchantment",
                    "faction": "Neutral",
                    "rarity": "Common",
                    "attack": 4,
                    "cost": 5,
                    "health": 4,
                    "playerClass": "Paladin",
                    "locale": "enUS"
                }
            ],
            "Classic": [],
            "Hall of Fame": []
        }
        """
        mockNetworkService.mockData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Cards fetched")
        
        sut.getAllCards { result in
            switch result {
            case .success(let categories):
                XCTAssertEqual(categories.count, 3) // 3 categories: Basic, Classic, Hall of Fame
                let card = categories["Basic"]?.first
                XCTAssertEqual(card?.cardId, "RLK_Prologue_CS2_092e")
                XCTAssertEqual(card?.dbfId, 100672)
                XCTAssertEqual(card?.name, "Blessing of Kings")
                XCTAssertEqual(card?.flavor, "Give a minion +4/+4. (+4 Attack/+4 Health)")
                XCTAssertEqual(card?.description, "Short description")
                XCTAssertEqual(card?.cardSet, "Basic")
                XCTAssertEqual(card?.type, "Enchantment")
                XCTAssertEqual(card?.faction, "Neutral")
                XCTAssertEqual(card?.rarity, "Common")
                XCTAssertEqual(card?.attack, 4)
                XCTAssertEqual(card?.cost, 5)
                XCTAssertEqual(card?.health, 4)
                XCTAssertEqual(card?.playerClass, "Paladin")
                XCTAssertEqual(card?.locale, "enUS")
            case .failure(let error):
                XCTFail("Error should not occur: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testGetAllCardsReturnsErrorWhenAPIFails() {
        let error = NSError(domain: "", code: 400, userInfo: nil)
        mockNetworkService.mockError = error
        
        let expectation = self.expectation(description: "API failure")
        
        sut.getAllCards { result in
            
            switch result {
            case .success(_):
                XCTFail("Success should not occur")
            case .failure(let error as NSError):
                XCTAssertEqual(error.code, 400)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
