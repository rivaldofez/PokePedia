//
//  DetailPokemonViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

protocol DetailPokemonViewProtocol {
    var presenter: DetailPokemonPresenterProtocol? { get set }
    
    func updatePokemonSpecies(with pokemonSpecies: PokemonSpecies)
    func updatePokemonSpecies(with error: String)
    
    func updatePokemon(with pokemon: Pokemon)
    
    func isLoadingData(with state: Bool)
}


class DetailPokemonViewController: UIViewController, DetailPokemonViewProtocol {
    
    
    var presenter: DetailPokemonPresenterProtocol?
    
    func updatePokemonSpecies(with pokemonSpecies: PokemonSpecies) {
        print("Pokemon Species \(pokemonSpecies.genus)")
    }
    
    func updatePokemon(with pokemon: Pokemon) {
        print("Pokemon \(pokemon.name)")
    }
    
    func isLoadingData(with state: Bool) {
        
    }
    
    func updatePokemonSpecies(with error: String) {
        print(error)
    }
    
    private enum SectionTabs: String {
        case about = "About"
        case stat = "Base Stat"
        case moves = "Moves"
        
        var index: Int {
            switch self {
            case .about:
                return 0
            case .stat:
                return 1
            case .moves:
                return 2
            }
        }
        
        static let allCases = [about, stat, moves]
    }
    
    private var sectionTabButtons: [UIButton] = SectionTabs.allCases.map { sectionCase in
        let button = UIButton(type: .system)
        button.setTitle(sectionCase.rawValue, for: .normal)
        button.titleLabel?.font = .poppinsBold(size: 14)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var sectionStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: sectionTabButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
        
    }()
    
    
    private var chipType: [UIStackView] = ["Grass", "Fire", "Flying"].map { title in
        let stackView = UIStackView()
        
        let label = UILabel()
        label.font = .poppinsMedium(size: 12)
        label.text = title
        
        let imageview = UIImageView()
        imageview.image = UIImage(named: "grass")
        imageview.contentMode = .scaleAspectFit
        imageview.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageview.clipsToBounds = true
    
        stackView.spacing = 5
        stackView.addArrangedSubview(imageview)
        stackView.addArrangedSubview(label)
        
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
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
    
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    private var selectedTab: Int = 0 {
        didSet {
            for i in 0 ..< sectionTabButtons.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStackView.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    
                    self?.view.layoutIfNeeded()
                }
            }
            
            print(selectedTab)
        }
    }
    
    private var sectionViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "charizard")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    private lazy var aboutSubViewController = AboutSubViewController()
    private lazy var baseStatSubViewController = BaseStatSubViewController()
    private lazy var movesSubViewController = MovesSubViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Charizard"
        navigationController?.navigationBar.tintColor = .label
        
        let attrs = [
            NSAttributedString.Key.font: UIFont.poppinsBold(size: 34)!
        ]

        navigationController?.navigationBar.largeTitleTextAttributes = attrs

        view.addSubview(pokemonTypeStackView)
        view.addSubview(pokemonImageView)
        view.addSubview(sectionStackView)
        view.addSubview(indicator)
        view.addSubview(sectionViewContainer)
        addSubViewController(viewController: aboutSubViewController, contentView: sectionViewContainer)
        
        configureConstraints()
        configureStackButton()
    }
    
    private func configureStackButton(){
        for (i, button) in sectionStackView.arrangedSubviews.enumerated(){
            guard let button = button as? UIButton else { return }
            
            if i == selectedTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func didTapTab(_ sender: UIButton){
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case SectionTabs.about.rawValue:
            selectedTab = 0
            removeSubViewController(viewController: baseStatSubViewController)
            removeSubViewController(viewController: movesSubViewController)
            addSubViewController(viewController: aboutSubViewController, contentView: sectionViewContainer)
        case SectionTabs.stat.rawValue:
            selectedTab = 1
            removeSubViewController(viewController: aboutSubViewController)
            removeSubViewController(viewController: movesSubViewController)
            addSubViewController(viewController: baseStatSubViewController, contentView: sectionViewContainer)
        case SectionTabs.moves.rawValue:
            selectedTab = 2
            removeSubViewController(viewController: baseStatSubViewController)
            removeSubViewController(viewController: aboutSubViewController)
            addSubViewController(viewController: movesSubViewController, contentView: sectionViewContainer)
        default:
            removeSubViewController(viewController: baseStatSubViewController)
            removeSubViewController(viewController: movesSubViewController)
            addSubViewController(viewController: aboutSubViewController, contentView: sectionViewContainer)
            selectedTab = 0
        }
    }
    
    private func configureConstraints(){
        let pokemonImageViewConstraints = [
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: min(view.frame.width/2, view.frame.height/2))
        ]

        let pokemonTypeStackViewConstraints = [
            pokemonTypeStackView.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 16),
            pokemonTypeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ]
        
        for i in 0 ..< sectionTabButtons.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        let sectionStackViewConstraints = [
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sectionStackView.topAnchor.constraint(equalTo: pokemonTypeStackView.bottomAnchor, constant: 16),
            sectionStackView.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let indicatorConstraints = [
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ]
        
        let sectionViewContainerConstraints = [
            sectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sectionViewContainer.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 20),
            sectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(pokemonTypeStackViewConstraints)
        NSLayoutConstraint.activate(sectionStackViewConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
        NSLayoutConstraint.activate(sectionViewContainerConstraints)
    }
    
    private func removeSubViewController(viewController: UIViewController){
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func addSubViewController(viewController: UIViewController, contentView: UIView){
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewController.view)
        
        let matchConstraints = [
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(matchConstraints)
        viewController.didMove(toParent: self)
    }
}
