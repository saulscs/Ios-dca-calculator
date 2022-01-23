//
//  DCAService.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 22/01/22.
//

import Foundation

struct DCAService {
    func calcualte(initialInvesmentAmount: Double, monthlyCostAveringAmount: Double, initialDateOfInvesmentIndex: Int) -> DCAResult{
        
        return .init(currentValue: 0,
                     investmentAmount: 0,
                     gain: 0,
                     yield: 0,
                     annualReturn: 0)
    }
}

struct DCAResult{
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
}
