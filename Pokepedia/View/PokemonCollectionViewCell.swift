//
//  PokemonCollectionViewCell.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 06/02/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "charizard")
        return imageView
    }()
    
    private let pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "999"
        label.textAlignment = .left
        return label
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mega Venusaur"
        label.numberOfLines = 2
        label.textAlignment = .left
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.yellow.cgColor
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(pokemonNumberLabel)
        contentView.addSubview(pokemonNameLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let pokemonImageViewConstraints = [
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokemonImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height/2)
        ]
        
        let pokemonNumberLabelConstraints = [
            pokemonNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pokemonNumberLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 16)
        ]
        
        let pokemonNameLabelConstraints = [
            pokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                      constant: -8),
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonNumberLabel.bottomAnchor, constant: 4)
        ]
        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(pokemonNumberLabelConstraints)
        NSLayoutConstraint.activate(pokemonNameLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
