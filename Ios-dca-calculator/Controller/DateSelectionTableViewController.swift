//
//  DateSelectionTableViewController.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 18/01/22.
//

import Foundation
import UIKit

class DateSelectionTableViewController: UITableViewController{
    
    var timeSerieMonthlyAdjusted: TimeSerieMonthlyAdjusted?
    private var monthInfos: [MothInfo] = []
    
    var didSelectDate: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthInfos()
        setupNavigation()
        
    }
    
    private func setupNavigation(){
        title = "Select date"
    }
    
    private func setupMonthInfos(){
        monthInfos = timeSerieMonthlyAdjusted?.getMonthInfos() ?? []
        
    }
}

extension DateSelectionTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! DateSelectionTableViewCell
        let index = indexPath.item
        let monthInfo = monthInfos[index]
        cell.configure(with: monthInfo, index: index)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDate?(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class DateSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthsAgoLabel: UILabel!
    
    func configure(with moreInfo: MothInfo, index: Int){
        monthLabel.text = moreInfo.date.MMYYFormat
        
        if index == 1 {
            monthsAgoLabel.text = "1 month ago"
        } else if index > 1 {
            monthsAgoLabel.text = "\(index) months ago"
        } else {
            monthsAgoLabel.text = "Just Invested"
        }
    }
}
