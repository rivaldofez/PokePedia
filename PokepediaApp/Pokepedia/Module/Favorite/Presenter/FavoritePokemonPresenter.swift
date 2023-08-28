//
//  FavoritePokemonPresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 26/08/23.
//

import Foundation
import PokepediaPokemon
import PokepediaCore
import RxSwift

protocol FavoritePokemonPresenterProtocol {
    var router: FavoriteRouterProtocol? { get set }
    var favoriteInteractor: Interactor<
        String,
        [PokemonDomainModel],
        GetFavoritePokemonsRepository<
        FavoritePokemonLocaleDataSource,
        PokemonsTransformer>>? { get set }
    
    var toggleFavoriteInteractor: Interactor<
        PokemonDomainModel,
        Bool,
        ToggleFavoritePokemonRepository<
            PokemonLocaleDataSource,
            PokemonTransformer>>? { get set }
    
    var view: FavoriteViewProtocol? { get set }
    
    var isLoadingData: Bool { get set }
    func getSearchPokemon(query: String?)
    func didSelectPokemonItem(with pokemon: PokemonDomainModel)
    func saveToggleFavorite(pokemon: PokemonDomainModel)
}

class FavoritePokemonPresenter: FavoritePokemonPresenterProtocol {
    var favoriteInteractor: Interactor<String, [PokemonDomainModel], GetFavoritePokemonsRepository<FavoritePokemonLocaleDataSource, PokemonsTransformer>>? {
        didSet {
            getSearchPokemon(query: nil)
        }
    }
    
    var toggleFavoriteInteractor: Interactor<PokemonDomainModel, Bool, ToggleFavoritePokemonRepository<PokemonLocaleDataSource, PokemonTransformer>>?
    
    private let disposeBag = DisposeBag()
    
    var router: FavoriteRouterProtocol?
    
    var view: FavoriteViewProtocol?
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getSearchPokemon(query: String?) {
        self.isLoadingData = true
        favoriteInteractor?.execute(request: query)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                self?.view?.updatePokemonFavorite(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemonFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func didSelectPokemonItem(with pokemon: PokemonDomainModel) {
        router?.gotoDetailPokemon(with: pokemon)
    }
    
    func saveToggleFavorite(pokemon: PokemonDomainModel) {
        toggleFavoriteInteractor?.execute(request: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.view?.updateSaveToggleFavorite(with: pokemon.isFavorite)
            } onError: { error in
                self.view?.updateSaveToggleFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
}
