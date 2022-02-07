//
//  Double+Extensions.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 22/01/22.
//

import Foundation

extension Double {
    var stringValue: String {
        return String(describing: self)
    }
    
    var twoDecimalPlaceString: String {
        return String(format: "%.2f", self)
    }
    
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: self as NSNumber) ?? twoDecimalPlaceString
    }
    
    func toCurrencyFormat(hasDollarSymbol: Bool = true, hasDecimalPlaces: Bool = true ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if hasDollarSymbol == false {
            formatter.currencySymbol = ""
        }
        
        if hasDecimalPlaces == false {
            formatter.maximumFractionDigits = 0
        }
        
        return formatter.string(from: self as NSNumber) ?? twoDecimalPlaceString
    }
}
