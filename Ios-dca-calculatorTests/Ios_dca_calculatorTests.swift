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
    
    
    

    // Format for test function name
    // what
    // given
    // expectation
    
    func testDCAResult_givenDCAIsUsed_expectResult(){
        
    }
    
    func testDCAResult_givenDCAIsNotUsed_expectResult(){
        
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
