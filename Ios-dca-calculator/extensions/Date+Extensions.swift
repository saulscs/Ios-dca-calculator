//
//  Date+Extensions.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 18/01/22.
//

import Foundation

extension Date {
    var MMYYFormat: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
