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
        
        let numberOfShares = getNumberOfShares(asset: asset,
                                               initialInvesmentAmount: investmentAmount,
                                               monthlyCostAveringAmount: monthlyCostAveringAmount,
                                               initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        
        let currentValue = getCurrentValue(numberOfShares: numberOfShares, latestSharePrice: latestSharePrice)
        
        let isProfitable = currentValue > investmentAmount
        
        let gain = currentValue - investmentAmount
        
        let yield = gain / investmentAmount
        
        let annualReturn = getAnnualReturn(currentValue: currentValue,
                                           investmentAmount: investmentAmount,
                                           initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
        
        return .init(currentValue: currentValue,
                     investmentAmount: investmentAmount,
                     gain: gain,
                     yield: yield,
                     annualReturn: annualReturn,
                     isProfitable: isProfitable)
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
    
    private func getAnnualReturn(currentValue: Double, investmentAmount: Double, initialDateOfInvesmentIndex: Int) -> Double {
        let rate = currentValue / investmentAmount
        let years = ((initialDateOfInvesmentIndex + 1) / 12).doubleValue
        return pow(rate, (1 / years)) - 1
    }
    
    private func getCurrentValue(numberOfShares: Double, latestSharePrice: Double) -> Double {
        return numberOfShares * latestSharePrice
    }
    
    private func getLatestSharePrice(asset: Asset ) -> Double{
        return  asset.timesSeriesMonthlyAdjusted.getMonthInfos().first?.adjustedClose ?? 0
    }
    
    private func getNumberOfShares (asset: Asset,
                                       initialInvesmentAmount: Double,
                                       monthlyCostAveringAmount: Double,
                                       initialDateOfInvesmentIndex: Int) -> Double {
        
        var totalShares = Double()
        
        let initialInvestmentOpenPrice = asset.timesSeriesMonthlyAdjusted.getMonthInfos()[initialDateOfInvesmentIndex].adjustedOpen
        let initialInvesmentShares = initialInvesmentAmount / initialInvestmentOpenPrice
        
        totalShares += initialInvesmentShares
        
        asset.timesSeriesMonthlyAdjusted.getMonthInfos().prefix(initialDateOfInvesmentIndex).forEach { (monthInfo) in
            let dcaInvestmentshares = monthlyCostAveringAmount / monthInfo.adjustedOpen
            
            totalShares += dcaInvestmentshares
        }
        
        return totalShares
    }
}

struct DCAResult{
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
    let isProfitable: Bool
}
