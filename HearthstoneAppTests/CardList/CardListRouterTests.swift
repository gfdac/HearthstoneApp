//
//  CardListRouterTests.swift
//  HearthstoneAppTests
//
//  Created by Guh F on 27/05/23.
//

import XCTest
@testable import HearthstoneApp

class CardListRouterTests: XCTestCase {
    var router: CardListRouter!
    var navigationControllerMock: NavigationControllerMock!

    override func setUp() {
        super.setUp()
        navigationControllerMock = NavigationControllerMock()
        router = CardListRouter(viewController: navigationControllerMock)
    }

    override func tearDown() {
        navigationControllerMock = nil
        router = nil
        super.tearDown()
    }

    func testNavigateToCardDetail() {
        // Given
        let card = CardListModels.Card(cardId: "cardId1", name: "Card 1", flavor: "Flavor 1", text: "Description 1", cardSet: "Set 1", type: "Type 1", faction: "Faction 1", rarity: "Rarity 1", attack: 1, cost: 1, health: 1, img: "Image 1")

        // When
        router.navigateToCardDetail(with: card)

        // Then
        XCTAssertTrue(navigationControllerMock.pushViewControllerCalled)
        XCTAssertTrue(navigationControllerMock.pushedViewController != nil)
    }
}

// MARK: - Mocks
class NavigationControllerMock: UINavigationController {
    var pushViewControllerCalled = false
    var pushedViewController: UIViewController?

    init() {
        super.init(rootViewController: UIViewController())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushedViewController = viewController

        super.pushViewController(viewController, animated: animated)
    }
}
