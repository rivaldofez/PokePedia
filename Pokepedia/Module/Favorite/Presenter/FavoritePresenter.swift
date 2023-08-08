//
//  FavoritePresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/08/23.
//

import Foundation
import RxSwift

protocol FavoritePresenterProtocol {
    var router: FavoriteRouterProtocol? { get set }
    var interactor: FavoriteUseCase? { get set }
    var view: FavoriteViewProtocol? { get set }
    
    var isLoadingData: Bool { get set }
    func getFavoritePokemonList()
    func didSelectPokemonItem(with pokemon: Pokemon)
    
}

class FavoritePresenter: FavoritePresenterProtocol {
    private let disposeBag = DisposeBag()
    
    var router: FavoriteRouterProtocol?
    
    var interactor: FavoriteUseCase? {
        didSet {
            getFavoritePokemonList()
        }
    }
    
    var view: FavoriteViewProtocol?
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func didSelectPokemonItem(with pokemon: Pokemon) {
        router?.gotoDetailPokemon(with: pokemon)
    }
    
    func getFavoritePokemonList() {
        isLoadingData = true
        interactor?.getFavoritePokemonList()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                self?.view?.updatePokemonFavorite(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemonFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
}

