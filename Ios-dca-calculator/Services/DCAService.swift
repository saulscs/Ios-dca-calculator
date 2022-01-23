//
//  DCAService.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 22/01/22.
//

import Foundation

struct DCAService {
    func calcualte(asset: Asset,
                   initialInvesmentAmount: Double,
                   monthlyCostAveringAmount: Double,
                   initialDateOfInvesmentIndex: Int) -> DCAResult{
        
        let investmentAmount = getInvesmentAmount(initialInvesmentAmount: initialInvesmentAmount,
                                                  monthlyCostAveringAmount: monthlyCostAveringAmount,
                                                  initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        
        let latestSharePrice = getLatestSharePrice(asset: asset)
        
        let currentValue = getCurrentValue(numberOfShares: 100, latestSharePrice: latestSharePrice)
        
        return .init(currentValue: currentValue,
                     investmentAmount: investmentAmount,
                     gain: 0,
                     yield: 0,
                     annualReturn: 0)
    }
    
    private func getInvesmentAmount(initialInvesmentAmount: Double,
                                    monthlyCostAveringAmount: Double,
                                    initialDateOfInvesmentIndex: Int) -> Double {
        var totalAmount = Double()
        totalAmount += initialInvesmentAmount
        let dollarCostAveragingAmount = initialDateOfInvesmentIndex.doubleValue * monthlyCostAveringAmount
        totalAmount += dollarCostAveragingAmount
        return totalAmount
    }
    
    private func getCurrentValue(numberOfShares: Double, latestSharePrice: Double) -> Double {
        return numberOfShares * latestSharePrice
    }
    
    private func getLatestSharePrice(asset: Asset ) -> Double{
        return  asset.timesSeriesMonthlyAdjusted.getMonthInfos().first?.adjustedClose ?? 0
    }
}

struct DCAResult{
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
}
