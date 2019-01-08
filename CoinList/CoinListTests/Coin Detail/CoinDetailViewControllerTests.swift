//
//  CoinDetailViewControllerTests.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 5/21/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import XCTest
@testable import CoinList

class CoinDetailViewControllerTests : XCTestCase {
    var viewController: CoinDetailViewController!
    var coin = Coin(name: "Bitcoin", symbol: "BTC", imageURL: nil)
    
    override func setUp() {
        super.setUp()
        viewController = CoinDetailViewController.makeFromStoryboard()
        viewController.cryptoCompareClient = MockCryptoClient()
        viewController.coin = coin
    }
    
}


