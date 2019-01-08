//
//  MockCryptoCompareClient.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 5/21/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation
import XCTest
@testable import CoinList

class MockCryptoClient : CryptoCompareClient {
    var fetchCallCount: Int = 0
    var priceCallCount: Int = 0
    var preparedCoinListResult: ApiResult<CoinList>?
    var preparedPriceResult: ApiResult<PriceResponse>?
    var delay: TimeInterval = 1
    var fetchExpectation: XCTestExpectation?
    
    init() {
        super.init(session: .shared)
    }
    
    convenience init(completingWith result: ApiResult<PriceResponse>? = nil) {
        self.init()
        preparedPriceResult = result
    }
    
    convenience init(completingWith result: ApiResult<CoinList>? = nil) {
        self.init()
        preparedCoinListResult = result
    }
    
    override func fetchCoinList(completion: @escaping (ApiResult<CoinList>) -> Void) {
        fetchCallCount += 1
        
        guard let completeWithResult = self.preparedCoinListResult else { return }
        
        fetchExpectation = XCTestExpectation(description: "coin list retrieved")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(completeWithResult)
            self.fetchExpectation?.fulfill()
        }
    }
    
    override func fetchPrices(fromSymbol: String, toSymbols: [String], completion: @escaping (ApiResult<PriceResponse>) -> Void) {
        priceCallCount += 1
        guard let priceResult = preparedPriceResult else { return }
        fetchExpectation = XCTestExpectation(description: "prices retrieved")
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(priceResult)
            self.fetchExpectation?.fulfill()
        }
    }
    
    func verifyFetchCalled(file: StaticString = #file, line: UInt = #line) {
        XCTAssert(fetchCallCount == 1, "fetchCoinList was not called", file: file, line: line)
    }
    
    func verifyPriceCalled(file: StaticString = #file, line: UInt = #line) {
        XCTAssert(priceCallCount == 1, "fetchPrice was not called", file: file, line: line)
    }
}

