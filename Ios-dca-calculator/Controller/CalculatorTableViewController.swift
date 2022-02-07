//
//  CalculatorTableViewController.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 15/01/22.
//

import Foundation
import UIKit
import Combine

class CalculatorTableViewController: UITableViewController {
    
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var invesmentAmountLabel: UILabel!
    @IBOutlet weak var gainLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var annualReturnLabel: UILabel!
    
    @IBOutlet weak var initialInvesmentAmountTexField: UITextField!
    @IBOutlet weak var monthlyDollarCostAveringTextField: UITextField!
    @IBOutlet weak var initialDateInvesmentTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet var currencyLabel: [UILabel]!
    @IBOutlet weak var investmentAmountCurrencyLabel: UILabel!
    @IBOutlet weak var dateSlider: UISlider!
    
    var asset: Asset?
    
    @Published private var initialDateOfInvesmentIndex: Int?
    @Published private var initialInvesmentAmount: Int?
    @Published private var monthlyDollarCostAveringAmount: Int?
    
    private var subscribers = Set<AnyCancellable>()
    private let dcaService = DCAService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpTextFields()
        observeForm()
        setupDateSlider()
        
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
    }
    
    private func setupDateSlider(){
        if let count = asset?.timesSeriesMonthlyAdjusted.getMonthInfos().count {
            let dateSliderCount = count - 1
            dateSlider.maximumValue = dateSliderCount.floatValue
        }
    }
    
    private func  observeForm() {
        $initialDateOfInvesmentIndex.sink { [weak self] (index) in
            guard let index = index else { return }
            self?.dateSlider.value = index.floatValue
            
            if let dateString = self?.asset?.timesSeriesMonthlyAdjusted.getMonthInfos()[index].date.MMYYFormat{
                self?.initialDateInvesmentTextField.text = dateString
            }
        }.store(in: &subscribers)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: initialInvesmentAmountTexField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink{ [weak self] (text) in
            self?.initialInvesmentAmount = Int(text) ?? 0
            print("initialInvesmentAmountTexField: \(text)")
        }.store(in: &subscribers)
        
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: monthlyDollarCostAveringTextField).compactMap({
            ($0.object as? UITextField)?.text
        }).sink{ [weak self] (text) in
            self?.monthlyDollarCostAveringAmount = Int(text) ?? 0
            print("monthlyDollarCostAveringTextField: \(text)")
        }.store(in: &subscribers)
        
        Publishers.CombineLatest3($initialInvesmentAmount, $monthlyDollarCostAveringAmount, $initialDateOfInvesmentIndex).sink{
            [weak self](initialInvesmentAmount, monthlyDollarCostAveringAmount, initialDateOfInvesmentIndex) in
            
            guard let initialInvesmentAmount = initialInvesmentAmount,
                  let monthlyDollarCostAveringAmount = monthlyDollarCostAveringAmount,
                  let initialDateOfInvesmentIndex = initialDateOfInvesmentIndex,
                  let asset = self?.asset else { return }
            
            
            let result = self?.dcaService.calcualte(asset: asset,
                                                    initialInvesmentAmount: initialInvesmentAmount.doubleValue,
                                                    monthlyCostAveringAmount: monthlyDollarCostAveringAmount.doubleValue,
                                                    initialDateOfInvesmentIndex: initialDateOfInvesmentIndex)
            
            let isProfitable = (result?.isProfitable == true)
            let gainSymbol = isProfitable ? "+" : ""
            
            self?.currentValueLabel.backgroundColor =  isProfitable ? .themeGreenshade  : .themeRedShade
            self?.currentValueLabel.text = result?.currentValue.currencyFormat
            self?.invesmentAmountLabel.text = result?.investmentAmount.currencyFormat
            self?.gainLabel.text = result?.gain.toCurrencyFormat(hasDollarSymbol: false, hasDecimalPlaces: false).prefix(withText: gainSymbol)
            self?.yieldLabel.text = result?.yield.percentageFormat.prefix(withText: gainSymbol).addBrackets()
            self?.yieldLabel.textColor = isProfitable ? .systemGreen : .systemRed
            self?.annualReturnLabel.text = result?.annualReturn.percentageFormat
            self?.annualReturnLabel.textColor = isProfitable ? .systemGreen : .systemRed
        }.store(in: &subscribers)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDateSelection", let dateSelectionTableViewController = segue.destination as? DateSelectionTableViewController,
           let timeSeriesMonthlyAdjusted = sender as? TimeSerieMonthlyAdjusted{
            dateSelectionTableViewController.timeSerieMonthlyAdjusted = timeSeriesMonthlyAdjusted
            dateSelectionTableViewController.selectedIndex = initialDateOfInvesmentIndex
            dateSelectionTableViewController.didSelectDate =  { [weak self] index in
                self?.handleDateSelection(at: index)
            }
        }
    }
    
    private func handleDateSelection(at index: Int){
        guard navigationController?.visibleViewController is DateSelectionTableViewController else { return }
        navigationController?.popViewController(animated: true)
        if let monthInfos = asset?.timesSeriesMonthlyAdjusted.getMonthInfos() {
            initialDateOfInvesmentIndex = index
            let monthInfo = monthInfos[index]
            let dateString = monthInfo.date.MMYYFormat
            initialDateInvesmentTextField.text = dateString
        }
    }
    
    @IBAction func dateSliderDidChange(_ sender: UISlider){
        initialDateOfInvesmentIndex = Int(sender.value)
        print(sender.value)
    }
}

extension CalculatorTableViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == initialDateInvesmentTextField {
            performSegue(withIdentifier: "showDateSelection", sender: asset?.timesSeriesMonthlyAdjusted)
            return false
        }
        return true
    }
}
