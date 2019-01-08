//
//  CoinListViewControllerTests.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 4/30/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
@testable import CoinList

class CoinListViewControllerTests : XCTestCase {
    
    var viewController: CoinListViewController!
    
    override func setUp() {
        super.setUp()

        OHHTTPStubs.failOnMissingStubs()
        OHHTTPStubs.stubImageRequests()
        viewController = CoinListViewController.makeFromStoryboard()
    }
    
    func testFetchesCoinsWhenLoaded() {
        let mockClient = MockCryptoClient()
        viewController.cryptoCompareClient = mockClient
        _ = viewController.view
        mockClient.verifyFetchCalled()
    }
    
    func testShowsLoadingIndicatorWhileFetching() {
        let mockClient = MockCryptoClient()
        viewController.cryptoCompareClient = mockClient
        _ = viewController.view
        XCTAssert(viewController.activityIndicator.isAnimating)
    }
    
    func testLoadingIndicatorHidesWhenFetchCompletes() {
        let coinList = emptyCoinList()
        let mockClient = MockCryptoClient(completingWith: .success(coinList))
        viewController.cryptoCompareClient = mockClient
        _ = viewController.view
        wait(for: [mockClient.fetchExpectation!], timeout: 3.0)
        XCTAssertFalse(viewController.activityIndicator.isAnimating)
    }
    
    func testReturnsRowsForEachCoin() {
        let coinList = buildCoinList(with: [
            CoinList.Coin(name: "Bitcoin", symbol: "BTC", imagePath: nil),
            CoinList.Coin(name: "Ethereum", symbol: "ETH", imagePath: nil),
            ])
        let mockClient = MockCryptoClient(completingWith: .success(coinList))
        viewController.cryptoCompareClient = mockClient
        _ = viewController.view
        wait(for: [mockClient.fetchExpectation!], timeout: 3.0)
        
        let rowCount = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 2)
    }
    
    func testReturnsCoinCells() {
        let coinList = buildCoinList(with: [
            CoinList.Coin(name: "Bitcoin", symbol: "BTC", imagePath: "/media/19633/btc.png"),
            CoinList.Coin(name: "Ethereum", symbol: "ETH", imagePath: nil),
            ])
        let mockClient = MockCryptoClient(completingWith: .success(coinList))
        viewController.cryptoCompareClient = mockClient
        _ = viewController.view
        wait(for: [mockClient.fetchExpectation!], timeout: 3.0)
        
        guard let cell = viewController.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CoinListCell else {
            XCTFail("Did not return the appropriate cell type")
            return
        }
        
        XCTAssertEqual(cell.coinNameLabel.text, "Ethereum")
        XCTAssertEqual(cell.coinSymbolLabel.text, "ETH")
    }
    
    private func emptyCoinList() -> CoinList {
        return buildCoinList(with: [])
    }
    
    private func buildCoinList(with coins: [CoinList.Coin]) -> CoinList {
        return CoinList(response: "",
                        message: "",
                        baseImageURL: URL(string: "https://min-api.cryptocompare.com")!,
                        baseLinkURL: URL(string: "https://min-api.cryptocompare.com")!, data: CoinList.Data(coins: coins))
    }
    
}
