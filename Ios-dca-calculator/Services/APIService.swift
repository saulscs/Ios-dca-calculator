//
//  APIService.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 07/01/22.
//

import Foundation
import Combine

struct APIService{
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
        
    let keys = ["44QB1VSCGH073Q7N", "3BCGRFWDHQHV6377", "MN2LT5ZLU7C713YE"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
