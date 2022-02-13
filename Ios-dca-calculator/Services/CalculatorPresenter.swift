//
//  CalculatorPresenter.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 13/02/22.
//

import UIKit

struct CalculatorPresenter{
    
    func getPresentation(result: DCAResult) -> CalculatorPresentation {
        let isProfitable = result.isProfitable == true
        let gainSymbol = isProfitable ? "+" : ""
        
        return .init(currentValueLabelBackgroundColor: isProfitable ? .themeGreenshade  : .themeRedShade,
                     currentValue: result.currentValue.currencyFormat,
                     invesmentAmount: result.investmentAmount.toCurrencyFormat(hasDecimalPlaces: false),
                     gain: result.gain.toCurrencyFormat(hasDollarSymbol: true, hasDecimalPlaces: false).prefix(withText: gainSymbol),
                     yield: result.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets(),
                     yieldLabelTextColor: isProfitable ? .systemGreen : .systemRed,
                     annualReturn: result.annualReturn.percentageFormat,
                     annualReturnLabelTextColor: isProfitable ? .systemGreen : .systemRed)
    }
}

struct CalculatorPresentation {
    let currentValueLabelBackgroundColor: UIColor
    let currentValue: String
    let invesmentAmount: String
    let gain: String
    let yield: String
    let yieldLabelTextColor: UIColor
    let annualReturn: String
    let annualReturnLabelTextColor: UIColor
}
