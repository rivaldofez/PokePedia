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
        imageView.alpha = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pokeballImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball")
        imageView.alpha = 0.3
        return imageView
    }()
    
    private let pokemonNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "999"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mega Venusaur"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.yellow.cgColor
        
        contentView.addSubview(pokeballImageView)
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(pokemonNumberLabel)
        contentView.addSubview(pokemonNameLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        
        let pokeballImageViewConstraints = [
            pokeballImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokeballImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pokeballImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokeballImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height/2)
        ]
        
        let pokemonImageViewConstraints = [
            pokemonImageView.leadingAnchor.constraint(equalTo: pokeballImageView.leadingAnchor, constant: 20),
            pokemonImageView.trailingAnchor.constraint(equalTo: pokeballImageView.trailingAnchor, constant: -20),
            pokemonImageView.topAnchor.constraint(equalTo: pokeballImageView.topAnchor, constant: 20),
            pokemonImageView.bottomAnchor.constraint(equalTo: pokeballImageView.bottomAnchor, constant: -20)
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
        NSLayoutConstraint.activate(pokeballImageViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
