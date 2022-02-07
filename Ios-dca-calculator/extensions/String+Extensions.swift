//
//  String+Extensions.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 17/01/22.
//

import Foundation

extension String{
    
    func addBrackets() -> String {
        return "(\(self))"
    }
    
    func prefix(withText text: String) -> String{
        return text + self
    }
}
