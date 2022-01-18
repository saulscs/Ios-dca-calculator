//
//  CalculatorTableViewController.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 15/01/22.
//

import Foundation
import UIKit

class CalculatorTableViewController: UITableViewController {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet var currencyLabel: [UILabel]!
    
    
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        symbolLabel.text = asset?.searchResult.symbol
        assetNameLabel.text = asset?.searchResult.name
        currencyLabel.forEach{(label) in
            label.text = asset?.searchResult.currency.addBrackets()
        }
    }
}


