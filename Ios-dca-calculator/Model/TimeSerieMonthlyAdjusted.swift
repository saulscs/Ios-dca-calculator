//
//  TimeSerieMonthlyAdjusted.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 13/01/22.
//

import Foundation

struct MothInfo{
    let date: Date
    let adjustedOpen: Double
    let adjustedClose: Double
}

struct TimeSerieMonthlyAdjusted: Decodable{
    let meta: Meta
    let timeSeries: [String: OHLC]
    
    enum CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case timeSeries = "Monthly Adjusted Time Series"
    }
    
    func getMonthInfos() -> [MothInfo] {
        var monthInfos: [MothInfo] = []
        let sortedTimesSeries = timeSeries.sorted(by: { $0.key > $1.key })
        print("sorted: \(sortedTimesSeries)")
        return monthInfos
    }
}

struct Meta: Decodable {
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC: Decodable {
    let open: String
    let close: String
    let adjustedClose: String
    
    enum  CodingKeys: String, CodingKey{
        case open = "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }
}
