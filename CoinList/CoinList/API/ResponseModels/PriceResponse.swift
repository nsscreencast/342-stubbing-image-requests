//
//  CoinPrice.swift
//  CoinList
//
//  Created by Ben Scheirman on 5/21/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import Foundation

struct PriceResponse : Decodable {
    private let prices: [String : Decimal]
    
    init(prices: [String: Decimal]) {
        self.prices = prices
    }
    
    var count: Int {
        return prices.keys.count
    }
    
    var symbols: [String] {
        return prices.keys.sorted()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var prices: [String: Decimal] = [:]
        for key in container.allKeys {
            let price = try container.decode(Decimal.self, forKey: key)
            prices[key.stringValue] = price
        }
        self.prices = prices
    }
    
    subscript(key: String) -> Decimal? {
        return prices[key]
    }
    
    private struct CodingKeys : CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            self.stringValue = String(intValue)
        }
    }
}
