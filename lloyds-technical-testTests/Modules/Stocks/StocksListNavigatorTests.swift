//
//  StockListNavigatorTests.swift
//  lloyds-technical-testTests
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import XCTest
@testable import lloyds_technical_test

class StocksListNavigatorTests: XCTestCase {
    var navigator: StocksListNavigator!
    var mockedNavigationController = MockedNavigationController()
    
    override func setUpWithError() throws {
        navigator = StocksListNavigator(navigationController: mockedNavigationController)
    }
    
    override func tearDownWithError() throws {
        navigator = nil
    }
    
    func testExample() throws {
        navigator.navigate(to: .quotesList, navigationType: .push)
        XCTAssertTrue(mockedNavigationController.pushedViewController is StocksViewProtocol)
    }
}
