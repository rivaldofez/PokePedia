//
//  PokemonDetailViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/02/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "charizard")
        
        return imageView
    }()
    
    private let pokemonHeightLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.5m"
        return label
    }()
    
    private let pokemonNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Charizard"
        return label
    }()
    
    private let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10 kg"
        return label
    }()
    
    private let pokemonSpeciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seed Pokemon"
        return label
    }()
    
    private let pokemonBaseExpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "64"
        return label
    }()
    
    private let pokemonIDLabel: UILabel = {
        let label = UILabel()
        label.text = "999"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let brief: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonBriefLabel: UILabel = {
        let label = UILabel()
        label.text = "This is brief explanation about pokemon, so you need to adjust size of this text label"
        return label
    }()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private var test: [UIButton] = ["Tweets", "Media", "Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        button.tintColor = .label
        button.backgroundColor = .systemBlue
        return button
    }
    
    private lazy var pokemonTypeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: test)

        stackView.axis = .horizontal
//        stackView.distribution = .equalCentering
//        stackView.alignment = .center
        return stackView
    }()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(mainStackView)
        configureConstraints()
        
        mainStackView.addArrangedSubview(pokemonImageView)
        mainStackView.addArrangedSubview(pokemonNameLabel)
        mainStackView.addArrangedSubview(pokemonTypeStackView)
        mainStackView.addArrangedSubview(brief)
        mainStackView.addArrangedSubview(pokemonBriefLabel)
        

    }

    private func configureConstraints(){
        let mainStackViewConstraints = [
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
//            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(mainStackViewConstraints)
    }

}