//
//  FavoriteViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 02/08/23.
//

import UIKit
import RxSwift

protocol FavoriteViewProtocol {
    var presenter: FavoritePresenterProtocol? { get set }
    
    func updatePokemonFavorite(with pokemons: [Pokemon])
    func updatePokemonFavorite(with error: String)
    func isLoadingData(with state: Bool)
}

class FavoriteViewController: UIViewController, FavoriteViewProtocol {
    var presenter: FavoritePresenterProtocol?
    
    func updatePokemonFavorite(with pokemons: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemonData.removeAll()
            self.pokemonData.append(contentsOf: pokemons)
            self.pokemonTableView.reloadData()
        }
    }
    
    func updatePokemonFavorite(with error: String) {
        print("failed \(error)")
    }
    
    func isLoadingData(with state: Bool) {
        
    }
    
    private var pokemonData: [Pokemon] = []
    private let disposeBag = DisposeBag()
    
    private lazy var pokemonTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite Pokémon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(pokemonTableView)
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        let pokemonTableViewConstraints = [
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(pokemonTableViewConstraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavoritePokemonList()
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            
            presenter?.saveFavoritePokemon(pokemon: model)
            pokemonData.remove(at: indexPath.row)
            
            tableView.endUpdates()
        }
    }
    
}
