//
//  HomeViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 05/02/23.
//

import UIKit
import RxSwift
import Alamofire

class HomeViewController: UIViewController {
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
        
//        let result = PokemonRepository.shared.getPokemonDataPagination(offset: 0, limit: 10)
//
//        result.observe(on: MainScheduler.instance)
//            .subscribe{ resultItem in
//                let mapperResult = PokemonMapper.mapPokemonDetailResponsesToDomain(input: resultItem)
//                for i in mapperResult {
//                    print(i.image)
//                }
//            } onError: { error in
//                print("error")
//            } onCompleted: {
//                print("completed")
//            }.disposed(by: disposeBag)
//
//
//        let resSpecies = PokemonRepository.shared.getPokemonSpecies(id: 2)
//        resSpecies.observe(on: MainScheduler.instance)
//            .subscribe{ resultItem in
//                print(resultItem.color)
//            } onError: { error in
//                print("error2")
//            } onCompleted: {
//                print("completed2")
//            }.disposed(by: disposeBag)
        
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
}
