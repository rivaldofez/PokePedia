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
        return label
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mega Venusaur"
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
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
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        

        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
