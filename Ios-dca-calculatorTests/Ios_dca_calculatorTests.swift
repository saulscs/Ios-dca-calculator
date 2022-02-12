//
//  Ios_dca_calculatorTests.swift
//  Ios-dca-calculatorTests
//
//  Created by saul corona on 07/02/22.
//

import XCTest
@testable import Ios_dca_calculator

class Ios_dca_calculatorTests: XCTestCase {
    
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
        XCTAssertEqual(result.investmentAmount, 12500, "Invesment amount is incorrect")
    }
    
    func testResult_givenWinnigAssetsAndDCAIsNotUsed_expectPositiveGains(){
        // given
        // when
        // then
    }
    
    func testResult_givenLosingAssetsAndDCAIsUsed_expectNegativeGains(){
        // given
        // when
        // then
    }
    
    func testResult_givenLosingAssetsAndDCAIsNotUsed_expectNegativeGains(){
        // given
        // when
        // then
    }
    
    
    private func buildWinningAsset() -> Asset {
        let searchResult = buildSearchResult()
        let meta = buildMeta()
        let timesSeries: [String: OHLC] = ["2021-01-25": OHLC(open: "100", close: "0", adjustedClose: "110"),
                                           "2021-02-25": OHLC(open: "110", close: "0", adjustedClose: "120"),
                                           "2021-03-25": OHLC(open: "120", close: "0", adjustedClose: "130"),
                                           "2021-04-25": OHLC(open: "130", close: "0", adjustedClose: "140"),
                                           "2021-05-25": OHLC(open: "140", close: "0", adjustedClose: "150"),
                                           "2021-06-25": OHLC(open: "150", close: "0", adjustedClose: "160"),]
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
