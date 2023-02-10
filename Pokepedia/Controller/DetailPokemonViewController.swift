//
//  DetailPokemonViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    private var chipType: [UIStackView] = ["Grass", "Fire", "Flying"].map { title in
        let stackView = UIStackView()
        
        let label = UILabel()
        label.text = title
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "grass")
        imageview.contentMode = .scaleAspectFit
        imageview.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageview.clipsToBounds = true
    
        stackView.spacing = 5
        stackView.addArrangedSubview(imageview)
        stackView.addArrangedSubview(label)
        
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .gray
        stackView.layer.cornerRadius = 15

        
        return stackView
    }
    
    private lazy var pokemonTypeStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        for chip in chipType {
            stackView.addArrangedSubview(chip)
        }
        
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    private let pokemonImageView: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "charizard")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Charizard"
        navigationController?.navigationBar.tintColor = .label

        view.addSubview(pokemonTypeStackView)
        view.addSubview(pokemonImageView)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let pokemonImageViewConstraints = [
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: min(view.frame.width/2, view.frame.height/2))
        ]

        let pokemonTypeStackViewConstraints = [
            pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 10),
            pokemonTypeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(pokemonTypeStackViewConstraints)
    }


}

extension UIView {

    static func spacer(size: CGFloat = 10, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()
        
        if layout == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        return spacer
    }

}
