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
    var monthInfos: [MothInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthInfos()
        
    }
    
    private func setupMonthInfos(){
        if let monthInfos = timeSerieMonthlyAdjusted?.getMonthInfos() {
            self.monthInfos = monthInfos
        }
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
        let monthInfo = monthInfos[indexPath.item]
        cell.configure(with: monthInfo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class DateSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthsAgoLabel: UILabel!
    
    func configure(with moreInfo: MothInfo){
        backgroundColor = .red
    }
}
