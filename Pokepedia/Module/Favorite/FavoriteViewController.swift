//
//  FavoriteViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 02/08/23.
//

import UIKit
import RxSwift
import Lottie

protocol FavoriteViewProtocol {
    var presenter: FavoritePresenterProtocol? { get set }
    
    func updatePokemonFavorite(with pokemons: [Pokemon])
    func updatePokemonFavorite(with error: String)
    func updateSaveToggleFavorite(with error: String)
    func updateSaveToggleFavorite(with state: Bool)
    func isLoadingData(with state: Bool)
}

class FavoriteViewController: UIViewController, FavoriteViewProtocol {

    var presenter: FavoritePresenterProtocol?
    
    private var pokemonData: [Pokemon] = []
    private let disposeBag = DisposeBag()
    
    // MARK: View Components
    // Favorite Table View
    private lazy var pokemonTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return tableView
    }()
    
    // Loading View
    private lazy var loadingAnimation: LottieAnimationView = {
        let lottie = LottieAnimationView(name: "loading")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.play()
        lottie.loopMode = .loop
        return lottie
    }()
    
    private lazy var backdropLoading: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    // Error View
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error occured while load pokemon data"
        label.textColor = .label
        label.font = .poppinsBold(size: 16)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var errorAnimation: LottieAnimationView = {
        let lottie = LottieAnimationView(name: "error")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.heightAnchor.constraint(equalToConstant: 200).isActive = true
        lottie.play()
        lottie.loopMode = .loop
        return lottie
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [errorAnimation, errorLabel])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 16
        stackview.isHidden = true
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite Pokémon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(pokemonTableView)
        view.addSubview(errorStackView)
        view.addSubview(backdropLoading)
        view.addSubview(loadingAnimation)
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        configureConstraints()
        
    }
    
    // MARK: Auto Layout Constraints
    private func configureConstraints() {
        let pokemonTableViewConstraints = [
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let errorStackViewConstraints = [
            errorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let loadingAnimationConstraints = [
            loadingAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimation.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(errorStackViewConstraints)
        NSLayoutConstraint.activate(loadingAnimationConstraints)
        NSLayoutConstraint.activate(pokemonTableViewConstraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavoritePokemonList()
    }
    
    // MARK: Presenter Action
    
    func updateSaveToggleFavorite(with error: String) {
        func updateSaveToggleFavorite(with error: String) {
            showToggleFavoriteAlert(title: "An Error Occured", message: "Oops, cannot process your due to system error, please try again")
        }
        presenter?.getFavoritePokemonList()
    }
    
    func updateSaveToggleFavorite(with state: Bool) {
        if state {
            showToggleFavoriteAlert(title: "Added To Favorite", message: "This pokemon successfully added to your favorite list")
        } else {
            showToggleFavoriteAlert(title: "Removed From Favorite", message: "This pokemon successfully removed from your favorite list")
        }
    }
    
    func updatePokemonFavorite(with pokemons: [Pokemon]) {
        if pokemons.isEmpty {
            DispatchQueue.main.async {
                self.pokemonData.removeAll()
                self.pokemonTableView.reloadData()
                self.showError(isError: true, message: "There is no pokemon added to favorite", animation: "empty")
            }
        } else {
            DispatchQueue.main.async {
                self.pokemonData.removeAll()
                self.pokemonData.append(contentsOf: pokemons)
                self.pokemonTableView.reloadData()
                self.showError(isError: false)
            }
        }
    }
    
    func updatePokemonFavorite(with error: String) {
        showError(isError: true, message: "Error occured while load pokemon data", animation: "error")
    }
    
    func isLoadingData(with state: Bool) {
        showLoading(isLoading: state)
    }
    
    private func showToggleFavoriteAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
    }
    
    private func showError(isError: Bool, message: String? = nil, animation: String? = nil ) {
        if let message = message, let animation = animation {
            errorLabel.text = message
            errorAnimation.animation = LottieAnimation.named(animation)
            errorAnimation.play()
        }
        
        UIView.transition(with: errorStackView, duration: 0.4, options: .transitionCrossDissolve) {
            self.errorStackView.isHidden = !isError
        }
        
        UIView.transition(with: pokemonTableView, duration: 0.4, options: .transitionCrossDissolve) {
            self.pokemonTableView.isHidden = isError
        }
    }
    
    private func showLoading(isLoading: Bool) {
        UIView.transition(with: loadingAnimation, duration: 0.4, options: .transitionCrossDissolve) {
            self.loadingAnimation.isHidden = !isLoading
        }
        
        UIView.transition(with: backdropLoading, duration: 0.4, options: .transitionCrossDissolve) {
            self.backdropLoading.isHidden = !isLoading
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pokemonData.count == 0 {
            self.showError(isError: true, message: "There is no pokemon added to favorite", animation: "empty")
        }
        
        return pokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let model = pokemonData[indexPath.row]
        cell.configure(with: model)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectPokemonItem(with: pokemonData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            var model = pokemonData[indexPath.row]
            model.isFavorite = false
            
            presenter?.saveToggleFavorite(pokemon: model)
            pokemonData.remove(at: indexPath.row)
            
            tableView.endUpdates()
        }
    }
    
}
