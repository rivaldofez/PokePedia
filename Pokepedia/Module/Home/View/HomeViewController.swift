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
    
    private var pokemonDataPagination: [Pokemon] = []
    
    func isLoadingData(with state: Bool) {
        print("loading data: \(state)")
    }
    
    func updatePokemon(with pokemons: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemonDataPagination.append(contentsOf: pokemons)
            self.pokemonCollectionView.reloadData()
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
    
    private func createSpinnerFooter() -> UIView {
        let footerview = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        footerview.addSubview(spinner)
        spinner.center = footerview.center
        spinner.startAnimating()
        
        return footerview
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonDataPagination.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = pokemonDataPagination[indexPath.item]
        cell.configure(with: model)
            
            return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (pokemonCollectionView.contentSize.height - 100 - scrollView.frame.size.height){
            
            guard let isLoadingData = presenter?.isLoadingData else { return }
            if !isLoadingData {
                guard let offsetPagination = presenter?.offsetPagination else { return }
                
                presenter?.offsetPagination = offsetPagination + 50
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectPokemonItem(with: pokemonDataPagination[indexPath.item])
    }
}

//class IndicatorCell: UICollectionViewCell {
//
//    var indicator : UIActivityIndicatorView = {
//        let view = UIActivityIndicatorView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.style = .large
//        return view
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    func setup(){
//        contentView.addSubview(indicator)
//
////        inidicator.centerXAnchor = contentView.centerXAnchor
////        inidicator.centerYAnchor = contentView.centerYAnchor
//
//        indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        indicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//
//        indicator.startAnimating()
//    }
//
//}


