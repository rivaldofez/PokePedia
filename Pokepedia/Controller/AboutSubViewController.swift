//
//  AboutSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class AboutSubViewController: UIViewController {

    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Charizard, known in Japan as Lizardon, is a Pokémon in Nintendo and Game Freak's Pokémon franchise. Created by Atsuko Nishida, Charizard first appeared in the video games Pokémon Red and Blue and subsequent sequels."
        label.numberOfLines = 0
        return label
    }()
    
    private var weightLabelStackView: UIStackView = {
        let weightIcon = UIImageView()
        weightIcon.image = UIImage(named: "grass")
        weightIcon.contentMode = .scaleAspectFit
        weightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.clipsToBounds = true
        
        let label = UILabel()
        label.text = "10 Kg"
        
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(weightIcon)
        stackView.addArrangedSubview(label)
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight"
        
        let weightStackView = UIStackView()
        weightStackView.axis = .vertical
        weightStackView.addArrangedSubview(stackView)
        weightStackView.alignment = .center
        weightStackView.addArrangedSubview(weightLabel)
        weightStackView.backgroundColor = .gray
        
        return weightStackView
    }()
    
    private var heightLabelStackView: UIStackView = {
        let heightIcon = UIImageView()
        heightIcon.image = UIImage(named: "grass")
        heightIcon.contentMode = .scaleAspectFit
        heightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.clipsToBounds = true
        
        let label = UILabel()
        label.text = "10 m"
        
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(heightIcon)
        stackView.addArrangedSubview(label)
        
        let heightLabel = UILabel()
        heightLabel.text = "Height"
        
        let heightStackView = UIStackView()
        heightStackView.axis = .vertical
        heightStackView.addArrangedSubview(stackView)
        heightStackView.alignment = .center
        heightStackView.addArrangedSubview(heightLabel)
        heightStackView.backgroundColor = .gray
        
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
        stackView.spacing = 40
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
            sizeStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,constant: 10),
            sizeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(sizeStackViewConstraints)
    }
    
}
