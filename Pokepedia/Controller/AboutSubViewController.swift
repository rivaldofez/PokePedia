//
//  AboutSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class AboutSubViewController: UIViewController {
    var pokemonSpecies: PokemonSpecies? {
        didSet {
            guard let pokemonSpecies = pokemonSpecies else { return }
            let pokemonAbout = {
                return pokemonSpecies.about
                    .replacingOccurrences(of: "\n", with: " ")
                    .utf8EncodedString()
                    .replacingOccurrences(of: "\\014", with: " ")
                    .utf8DecodedString()
            }()
            
            aboutLabel.text = pokemonAbout
    
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            
            heightLabel.text = "\(pokemon.height) m"
            weightLabel.text = "\(pokemon.weight) kg"
        }
    }
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .comfortaaLight(size: 16)
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let heightLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weightLabelStackView: UIStackView = {
        let weightIcon = UIImageView()
        weightIcon.image = UIImage(named: "icon_width")
        weightIcon.frame = CGRect(x: 20, y: 0, width: 0, height: 0)
        weightIcon.contentMode = .scaleAspectFit
        weightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.clipsToBounds = true
        
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(weightIcon)
        stackView.addArrangedSubview(self.weightLabel)
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight"
        weightLabel.textAlignment = .center
        
        let weightStackView = UIStackView()
        weightStackView.axis = .vertical
        weightStackView.addArrangedSubview(stackView)
        weightStackView.alignment = .center
        weightStackView.addArrangedSubview(weightLabel)
       
        
        return weightStackView
    }()
    
    private lazy var heightLabelStackView: UIStackView = {
        let heightIcon = UIImageView()
        heightIcon.image = UIImage(named: "icon_height")
        heightIcon.contentMode = .scaleAspectFit
        heightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.clipsToBounds = true
        
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(heightIcon)
        stackView.addArrangedSubview(self.heightLabel)
        
        let heightLabel = UILabel()
        heightLabel.text = "Height"
        heightLabel.textAlignment = .center
        
        let heightStackView = UIStackView()
        heightStackView.axis = .vertical
        heightStackView.addArrangedSubview(stackView)
//        heightStackView.alignment = .center
        heightStackView.addArrangedSubview(heightLabel)
        
        return heightStackView
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        let uiview = UIView()
        uiview.heightAnchor.constraint(equalToConstant: 25).isActive = true
        uiview.widthAnchor.constraint(equalToConstant: 4).isActive = true
        uiview.backgroundColor = .red
        
        stackView.addArrangedSubview(weightLabelStackView)
        stackView.addArrangedSubview(uiview)
        stackView.addArrangedSubview(heightLabelStackView)
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 16
        stackView.clipsToBounds = true
        stackView.distribution = .equalSpacing
        
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(aboutLabel)
        view.addSubview(sizeStackView)
        configureConstraints()
        
    }
    
    private func configureConstraints(){
        let aboutLabelConstraints = [
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let sizeStackViewConstraints = [
            sizeStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,constant: 32),
            sizeStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            sizeStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            sizeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(sizeStackViewConstraints)
    }
    
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
