//
//  DetailPokemonViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
//    private var test: [UIButton] = ["Fire", "Flying", "Dragon"].map { buttonTitle in
//        let button = UIButton(type: .system)
//        button.setTitle(buttonTitle, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
//        button.layer.cornerRadius = 10
//
//        var configuration = UIButton.Configuration.filled()
//        configuration.image = UIImage(named: "grass")
//        configuration.titlePadding = 10
//        configuration.imagePadding = 10
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//        button.configuration = configuration
//
//        button.clipsToBounds = true
//        button.tintColor = .label
//        button.backgroundColor = .systemBlue
////        button.setImage(UIImage(named: "grass"), for: .normal)
//        return button
//    }
    
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
        

        
        stackView.spacing = 10
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
        
//        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Charizard"
        navigationController?.navigationBar.tintColor = .label

        view.addSubview(pokemonTypeStackView)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let pokemonTypeStackViewConstraints = [
//            pokemonTypeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pokemonTypeStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            pokemonTypeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonTypeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        
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
