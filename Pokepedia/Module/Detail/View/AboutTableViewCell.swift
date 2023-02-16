//
//  AboutTableViewCell.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 16/02/23.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    static let identifier = "AboutTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .poppinsBold(size: 14)
        label.text = "Weight"
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .comfortaaBold(size: 14)
        label.text = "100 Kg"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        configureConstraints()
    }
    
    private func configureConstraints(){
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let valueLabelConstraints = [
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(valueLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
