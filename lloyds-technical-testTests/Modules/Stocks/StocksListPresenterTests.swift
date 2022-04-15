//
//  StocksListPresenterTests.swift
//  lloyds-technical-testTests
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import XCTest
@testable import lloyds_technical_test

class StocksListPresenterTests: XCTestCase {
    
    var presenter: StocksListPresenterProtocol!

    override func setUpWithError() throws {
        let mockNetworking = MockNetworking()
        let service = StocksService(network: mockNetworking)
        presenter = StocksListPresenter(service: service)
    }

    override func tearDownWithError() throws {
        presenter = nil
    }

    func testExample() throws {
        presenter.fetchQuotes(for: Constants.initialSymbols)
        XCTAssertNotNil(presenter.quotes)
        XCTAssertEqual(presenter.numberOfRowsInSection(section: 0), 3)
    }
}
