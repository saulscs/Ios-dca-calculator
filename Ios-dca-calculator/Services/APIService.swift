//
//  APIService.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 07/01/22.
//

import Foundation
import Combine

struct APIService{
    
    enum APIServiceError: Error {
        case encoding
        case badRequest
    }
    
    var API_KEY: String {
        return keys.randomElement() ?? ""
    }
        
    let keys = ["44QB1VSCGH073Q7N", "3BCGRFWDHQHV6377", "MN2LT5ZLU7C713YE"]
    
    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResults, Error> {
        
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else { return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()}
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else { return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func fetchTimeSerieMonthlyAdjustedToPublisher(keywords: String) -> AnyPublisher<TimeSerieMonthlyAdjusted, Error> {
        guard let keywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else { return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()}
        
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=\(keywords)&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else { return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: TimeSerieMonthlyAdjusted.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
