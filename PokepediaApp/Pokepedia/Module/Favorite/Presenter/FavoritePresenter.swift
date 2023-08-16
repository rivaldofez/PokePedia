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
    func getSearchPokemon(query: String)
    func didSelectPokemonItem(with pokemon: Pokemon)
    func saveToggleFavorite(pokemon: Pokemon)
}

class FavoritePresenter: FavoritePresenterProtocol {
    
    private let disposeBag = DisposeBag()
    
    var router: FavoriteRouterProtocol?
    var view: FavoriteViewProtocol?
    var interactor: FavoriteUseCase? {
        didSet {
            getFavoritePokemonList()
        }
    }
    
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
    
    func getSearchPokemon(query: String) {
        interactor?.getSearchPokemon(query: query)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                self?.view?.updatePokemonFavorite(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemonFavorite(with: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func saveToggleFavorite(pokemon: Pokemon) {
        interactor?.saveFavoritePokemon(pokemon: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.view?.updateSaveToggleFavorite(with: result)
            } onError: { error in
                self.view?.updateSaveToggleFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
}
