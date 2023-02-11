//
//  MovesTableViewCell.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import UIKit

class MovesTableViewCell: UITableViewCell {

    static let identifier = "MovesTableViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Razor Leaf"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
