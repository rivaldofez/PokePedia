//
//  BaseStatCollectionViewCell.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import UIKit

class BaseStatTableViewCell: UITableViewCell {
    static let identifier = "BaseStatTableViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppinsBold(size: 14)
        label.text = "Sp.Atk"
        return label
    }()
    
    private let statLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .comfortaaBold(size: 14)
        label.text = "255"
        return label
    }()
    
    private let progressView: UIProgressView = {
       let progressview = UIProgressView()
        progressview.translatesAutoresizingMaskIntoConstraints = false
        return progressview
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(statLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(progressView)
        
        configureConstraints()
    
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .blue
    }
    
    func configure(with baseStat: BaseStat){
        titleLabel.text = baseStat.name
        statLabel.text = String(baseStat.value)
        progressView.setProgress(Float(baseStat.value) / 255.0, animated: false)
        
    }
    
    private func configureConstraints(){
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        let statLabelConstraints = [
            statLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            statLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            statLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        let progressViewConstraints = [
            progressView.leadingAnchor.constraint(equalTo: statLabel.trailingAnchor, constant: 16),
            progressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 5)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(statLabelConstraints)
        NSLayoutConstraint.activate(progressViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
