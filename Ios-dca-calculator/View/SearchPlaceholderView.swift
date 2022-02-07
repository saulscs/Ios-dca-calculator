//
//  SearchPlaceholderView.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 09/01/22.
//

import Foundation
import UIKit

class SearchPlaceholderView: UIView{
    
    private let imageView: UIImageView = {
        let image = UIImage(named: "imLaunch")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for companies to calculate potencial returns via dollar cost averaging."
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)!
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews(){
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo:centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}
