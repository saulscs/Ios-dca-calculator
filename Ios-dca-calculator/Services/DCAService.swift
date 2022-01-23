//
//  DCAService.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 22/01/22.
//

import Foundation

struct DCAService {
    func calcualte(initialInvesmentAmount: Double, monthlyCostAveringAmount: Double, initialDateOfInvesmentIndex: Int) -> DCAResult{
        
        let investmentAmount = getInvesmentAmount(initialInvesmentAmount: initialInvesmentAmount,
                                                  monthlyCostAveringAmount: monthlyCostAveringAmount,
                                                  initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        
        
        return .init(currentValue: 0,
                     investmentAmount: investmentAmount,
                     gain: 0,
                     yield: 0,
                     annualReturn: 0)
    }
    
    private func getInvesmentAmount(initialInvesmentAmount: Double, monthlyCostAveringAmount: Double, initialDateOfInvesmentIndex: Int) -> Double {
        var totalAmount = Double()
        totalAmount += initialInvesmentAmount
        let dollarCostAveragingAmount = initialDateOfInvesmentIndex.doubleValue * monthlyCostAveringAmount
        totalAmount += dollarCostAveragingAmount
        return totalAmount
    }
}

struct DCAResult{
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
}
