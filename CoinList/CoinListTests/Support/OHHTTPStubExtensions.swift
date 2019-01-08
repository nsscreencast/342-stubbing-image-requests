//
//  OHHTTPStubExtensions.swift
//  CoinListTests
//
//  Created by Ben Scheirman on 5/22/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation
import OHHTTPStubs

extension OHHTTPStubs {
    
    static func failOnMissingStubs() {
        OHHTTPStubs.onStubMissing { (req) in
            fatalError("Missing stub for \(req.url!)")
        }
    }
    
    static func stubImageRequests() {
        OHHTTPStubs.stubRequests(passingTest: pathMatches("\\.(png|jpg)")) { (req) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(), statusCode: 200, headers: [:])
        }
    }
}
