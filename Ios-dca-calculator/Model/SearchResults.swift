//
//  SearchResults.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 07/01/22.
//

import Foundation

struct SearchResults: Decodable{
    let items: [SearchResult]
    
    enum CodingKeys: String, CodingKey{
        case items = "bestMatches"
    }
}

struct SearchResult: Decodable {
    let symbol: String
    let name: String
    let currency: String
    let type: String
    
    enum CodingKeys: String, CodingKey{
        case symbol = "1. symbol"
        case name = "2. name"
        case currency = "8. currency"
        case type = "3. type"
    }
}
