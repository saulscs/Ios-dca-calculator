//
//  CalculatorTableViewController.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 15/01/22.
//

import Foundation
import UIKit

class CalculatorTableViewController: UITableViewController {
    @IBOutlet weak var initialInvesmentAmountTexField: UITextField!
    @IBOutlet weak var monthlyDollarCostAveringTextField: UITextField!
    @IBOutlet weak var initialDateInvesmentTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet var currencyLabel: [UILabel]!
    @IBOutlet weak var investmentAmountCurrencyLabel: UILabel!
    
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpTextFields()
        
    }
    
    private func setUpViews() {
        symbolLabel.text = asset?.searchResult.symbol
        assetNameLabel.text = asset?.searchResult.name
        investmentAmountCurrencyLabel.text = asset?.searchResult.currency
        currencyLabel.forEach{(label) in
            label.text = asset?.searchResult.currency.addBrackets()
        }
    }
    
    private func setUpTextFields() {
        initialInvesmentAmountTexField.addDoneButton()
        monthlyDollarCostAveringTextField.addDoneButton()
        initialDateInvesmentTextField.delegate = self
        
        //showDateSelection
    }
}

extension CalculatorTableViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == initialDateInvesmentTextField {
            performSegue(withIdentifier: "showDateSelection", sender: asset?.timesSeriesMonthlyAdjusted)
        }
        return false
    }
}


