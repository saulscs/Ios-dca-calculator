//
//  SearchTableViewCell.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 07/01/22.
//

import Foundation
import UIKit


class SearchTableViewCell: UITableViewCell{
    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!

    func configure(with searchResult: SearchResult){
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text = searchResult.type?.appending(" ").appending(searchResult.currency ?? "")
    }
}
