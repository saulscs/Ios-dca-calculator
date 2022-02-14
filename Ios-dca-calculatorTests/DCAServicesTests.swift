//
//  DCAServicesTests.swift
//  DCAServicesTest
//
//  Created by saul corona on 07/02/22.
//

import XCTest
@testable import Ios_dca_calculator

class DCAServicesTests: XCTestCase {
    
    // System under test
    var sut: DCAService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = DCAService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        sut = nil
    }
    
    
    //test cases
    // 1. assets = winnig | dca = true => positive gains
    // 2.  assets = winnig | dca = false => positive gains
    // 3.  assets = losing | dca = true  => negative gains
    // 3.  assets = losing | dca = false => negative gains
    

    // Format for test function name
    // what
    // given
    // expectation
    
    func testResult_givenWinnigAssetsAndDCAIsUsed_expectPositiveGains(){
        // given
        let initialInvesmentAmount: Double = 5000
        let monthlyCostAveringAmount: Double = 1500
        let initialDateOfInvesmentIndex: Int = 5
        let asset = buildWinningAsset()
        // when
        let result = sut.calcualte(asset: asset,
                                   initialInvesmentAmount: initialInvesmentAmount,
                                   monthlyCostAveringAmount: monthlyCostAveringAmount,
                                   initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        // then
        
        //initial invesment: $5000
        // DCA: $1500 x 5 = $7500
        // total: $5000 + $7500 = $12500
        
        XCTAssertEqual(result.investmentAmount, 12500)
        XCTAssertTrue(result.isProfitable)
        
        
        // jan: 5000 / 100 = 50 shares
        // feb: 1500 / 110 = 13.6363 shares
        // march: 1500 / 120 = 12.5 shares
        // april: 1500 / 130 = 11.5384 shares
        // may: 1500 / 140 = 10.7142
        // june: 1500 / 150 = 10 shares
        // total shares = 108.3889
        // total current value = 108.3889 x 160 (latest month closing price) = $17,342.224
        
        
        XCTAssertEqual(result.currentValue, 29342.257742257745, accuracy: 0.1)
        XCTAssertEqual(result.gain, 16842.25774257745, accuracy: 0.1)
        XCTAssertEqual(result.yield, 1.347380619406196, accuracy: 0.001)
    }
    
    func testResult_givenWinnigAssetsAndDCAIsNotUsed_expectPositiveGains(){
        // given
        let initialInvesmentAmount: Double = 5000
        let monthlyCostAveringAmount: Double = 0
        let initialDateOfInvesmentIndex: Int = 3
        let asset = buildWinningAsset()
        // when
        let result = sut.calcualte(asset: asset,
                                   initialInvesmentAmount: initialInvesmentAmount,
                                   monthlyCostAveringAmount: monthlyCostAveringAmount,
                                   initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        // then
        
        //initial invesment: $5000
        // DCA: $0 x 3 = $0
        // total: $5000 + $0 = $5000
        
        XCTAssertEqual(result.investmentAmount, 5000)
        XCTAssertTrue(result.isProfitable)
        
        

        // march: 5000 / 120 = 41.666 shares
        // april: 0 / 130 = 0 shares
        // may: 0 / 140 = 0 shares
        // june: 0 / 150 = 0 shares
        // total shares = 41.666
        // total current value = 108.3889 x 160 (latest month closing price) = $17,342.224
        
        
        XCTAssertEqual(result.currentValue, 6666.66, accuracy: 0.1)
        XCTAssertEqual(result.gain, 1666.66, accuracy: 0.1)
        XCTAssertEqual(result.yield, 0.3333, accuracy: 0.001)
    }
    
    func testResult_givenLosingAssetsAndDCAIsUsed_expectNegativeGains(){
        // given
        let initialInvesmentAmount: Double = 5000
        let monthlyCostAveringAmount: Double = 1500
        let initialDateOfInvesmentIndex: Int = 5
        let asset = buildLosingAsset()
        // when
        let result = sut.calcualte(asset: asset,
                                   initialInvesmentAmount: initialInvesmentAmount,
                                   monthlyCostAveringAmount: monthlyCostAveringAmount,
                                   initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        // then
        
        // then
        // Initial investment: $5000
        // DCA: $1500 X 5 = $7500
        // total: $5000 + $7500 = $12500
        
        XCTAssertEqual(result.investmentAmount, 12500)
        XCTAssertTrue(result.isProfitable)
        
        

        // Jan: $5000 / 170 = 29.4117 shares
        // Feb: $1500 / 160 = 9.375 shares
        // March: $1500 / 150 = 10 shares
        // April: $1500 / 140 = 10.7142 shares
        // May: $1500 / 130 = 11.5384 shares
        // June: $1500 / 120 = 12.5 shares
        // Total shares = 83.5393 shares
        // Total current value = 83.5393 X $110 (latest month closing price) = $9189.323
        // Gains = current value LESS investment amount: 9189.323 - 12500 = -3310.677
        // Yield = gains / investment amount: -3310.677 / 12500 = -0.2648
        
        
        XCTAssertEqual(result.currentValue, 14042.287491919844, accuracy: 0.1)
        XCTAssertEqual(result.gain, 1542.287491919844, accuracy: 0.1)
        XCTAssertEqual(result.yield, 0.12338299935358751, accuracy: 0.0001)
    }
    
    func testResult_givenLosingAssetsAndDCAIsNotUsed_expectNegativeGains(){
        // given
        let initialInvesmentAmount: Double = 5000
        let monthlyCostAveringAmount: Double = 0
        let initialDateOfInvesmentIndex: Int = 3
        let asset = buildLosingAsset()
        // when
        let result = sut.calcualte(asset: asset,
                                   initialInvesmentAmount: initialInvesmentAmount,
                                   monthlyCostAveringAmount: monthlyCostAveringAmount,
                                   initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        // then
        // Initial investment: $5000
        // DCA: $0 X 3 = $0
        // total: $5000 + $0 = $5000
        XCTAssertEqual(result.investmentAmount, 5000)
        XCTAssertFalse(result.isProfitable)
        
        // March: $5000 / 150 = 33.3333 shares
        // April: $0 / 140 = 0 shares
        // May: $0 / 130 = 0 shares
        // June: $0 / 120 = 0 shares
        // Total shares = 33.3333 shares
        // Total current value = 33.3333 X $110 (latest month closing price) = $3666.6666
        // Gains = current value LESS investment amount: 3666.666 - 5000 = -1333.333
        // Yield = gains / investment amount: -1333.333 / 5000 = -0.26666
        XCTAssertEqual(result.currentValue, 3666.666, accuracy: 0.1)
        XCTAssertEqual(result.gain, -1333.333, accuracy: 0.1)
        XCTAssertEqual(result.yield, -0.26666, accuracy: 0.0001)
    }
    
    
    private func buildWinningAsset() -> Asset {
        let searchResult = buildSearchResult()
        let meta = buildMeta()
        let timesSeries: [String: OHLC] = ["2021-01-25": OHLC(open: "100", close: "110", adjustedClose: "110"),
                                           "2021-02-25": OHLC(open: "110", close: "120", adjustedClose: "120"),
                                           "2021-03-25": OHLC(open: "120", close: "130", adjustedClose: "130"),
                                           "2021-04-25": OHLC(open: "130", close: "140", adjustedClose: "140"),
                                           "2021-05-25": OHLC(open: "140", close: "150", adjustedClose: "150"),
                                           "2021-06-25": OHLC(open: "150", close: "160", adjustedClose: "160"),]
        let timesSeriesMonthlyAdjusted = TimeSerieMonthlyAdjusted(meta: meta, timeSeries: timesSeries)
        
        return Asset(searchResult: searchResult, timesSeriesMonthlyAdjusted: timesSeriesMonthlyAdjusted)
    }
    
    
    private func buildLosingAsset() -> Asset {
        let searchResult = buildSearchResult()
        let meta = buildMeta()
        let timesSeries: [String : OHLC] = ["2021-01-25" : OHLC(open: "170", close: "160", adjustedClose: "160"),
                                           "2021-02-25" : OHLC(open: "160", close: "150", adjustedClose: "150"),
                                           "2021-03-25" : OHLC(open: "150", close: "140", adjustedClose: "140"),
                                           "2021-04-25" : OHLC(open: "140", close: "130", adjustedClose: "130"),
                                           "2021-05-25" : OHLC(open: "130", close: "120", adjustedClose: "120"),
                                           "2021-06-25" : OHLC(open: "120", close: "110", adjustedClose: "110")]
        
        let timesSeriesMonthlyAdjusted = TimeSerieMonthlyAdjusted(meta: meta, timeSeries: timesSeries)
        
        return Asset(searchResult: searchResult, timesSeriesMonthlyAdjusted: timesSeriesMonthlyAdjusted)
    }
    
    
    private func buildSearchResult() -> SearchResult {
        return SearchResult(symbol: "XYX", name: "XYX Company", type: "ETF", currency: "USD")
    }
    
    private func buildMeta() -> Meta {
        return Meta(symbol: "XYZ")
    }
    
    func testInvestment_whenDCAIsUsed_expectResult(){
        //given
        let initialInvesmentAmount:Double = 500
        let monthlyCostAveringAmount:Double = 100
        let initialDateOfInvesmentIndex = 4 // months ago
        //when
        let invesmentAmount = sut.getInvesmentAmount(initialInvesmentAmount: initialInvesmentAmount,
                                                     monthlyCostAveringAmount: monthlyCostAveringAmount,
                                                     initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        //then
        XCTAssertEqual(invesmentAmount, 900.0)
    }
    
    func testInvesmentAmount_whenDCAIsNotUsed_expectResult(){
        //given
        let initialInvesmentAmount:Double = 500
        let monthlyCostAveringAmount:Double = 100
        let initialDateOfInvesmentIndex = 4 // months ago
        //when
        let invesmentAmount = sut.getInvesmentAmount(initialInvesmentAmount: initialInvesmentAmount,
                                                     monthlyCostAveringAmount: monthlyCostAveringAmount,
                                                     initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        //then
        XCTAssertNotEqual(invesmentAmount, 1200.0)
    }
}
