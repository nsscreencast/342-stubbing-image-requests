//
//  FixtureLoader.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 2/23/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation
import OHHTTPStubs

class FixtureLoader {
    static func reset() {
        OHHTTPStubs.removeAllStubs()
    }
    
    static func stubCoinListResponse() {
        stub(condition:
        isHost("min-api.cryptocompare.com") && isPath("/data/all/coinlist")) { req -> OHHTTPStubsResponse in
            return jsonFixture(with: "coinlist.json")
        }
    }
    
    static func stubCoinListReturningError() {
        let data = "Server Error".data(using: .utf8)!
        stubCoinListWithData(data, statusCode: 500)
    }
    
    static func stubCoinListWithConnectionError(code: Int) {
        stub(condition:
        isHost("min-api.cryptocompare.com") && isPath("/data/all/coinlist")) { req -> OHHTTPStubsResponse in
            
            let fakeError = NSError(domain: "testdomain", code: code, userInfo: nil)
            return OHHTTPStubsResponse(error: fakeError)
        }
    }
    
    static func stubCoinListWithInvalidJSON() {
        let data = "this is not valid json".data(using: .utf8)!
        return stubCoinListWithData(data)
    }
    
    static func stubCoinListWithData(_ data: Data, statusCode: Int32 = 200) {
        stub(condition:
        isHost("min-api.cryptocompare.com") && isPath("/data/all/coinlist")) { req -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: data, statusCode: statusCode, headers: nil)
        }
    }
    
    static func stubPrice(symbols: [String]) {
        stub(
            condition: isHost("min-api.cryptocompare.com") && isPath("/data/price")
        ) { req -> OHHTTPStubsResponse in
            let filename = "price-\(symbols.sorted().joined(separator: ",").lowercased()).json"
            return jsonFixture(with: filename)
        }
    }
    
    private static func jsonFixture(with filename: String) -> OHHTTPStubsResponse {
        let bundle = OHResourceBundle("Fixtures", FixtureLoader.self)!
        guard let path = OHPathForFileInBundle(filename, bundle) else {
            fatalError("Missing fixture: \(filename)")
        }
        return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: nil)
    }
}
