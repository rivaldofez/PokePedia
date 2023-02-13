//
//  HomeViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 05/02/23.
//

import UIKit
import RxSwift
import Alamofire



protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func updatePokemon(with pokemons: [Pokemon])
    func updatePokemon(with error: String)
    
    func isLoadingData(with state: Bool)
}


class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    func isLoadingData(with state: Bool) {
        print("loading data: \(state)")
    }
    
    func updatePokemon(with pokemons: [Pokemon]) {
        for pokemon in pokemons {
            print(pokemon.name)
            if(pokemon.id == 10){
                presenter?.getPokemonDataPagination(offset: 100, limit: 50)
            }
        }
    }
    
    func updatePokemon(with error: String) {
        print("ini error: \(error)")
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var pokemonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: ((view.frame.size.width) / 3) - 10, height: (view.frame.size.width) / 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Pokémon"
        navigationController?.navigationBar.tintColor = .label
        
        view.backgroundColor = .systemBackground
        view.addSubview(pokemonCollectionView)
        
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pokemonCollectionView.frame = view.bounds
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (pokemonCollectionView.contentSize.height - 100 - scrollView.frame.size.height){
            print("fetch more")
        }
    }
}
