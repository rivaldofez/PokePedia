//
//  DetailPokemonRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import PokepediaPokemon
import PokepediaCore
import PokepediaSpecies

protocol DetailPokemonRouterProtocol {
    var entry: DetailPokemonViewController? { get }
    
    static func createDetailPokemon(with pokemon: PokemonDomainModel) -> DetailPokemonRouterProtocol
    
}

class DetailPokemonRouter: DetailPokemonRouterProtocol {
    var entry: DetailPokemonViewController?
    
    static func createDetailPokemon(with pokemon: PokemonDomainModel) -> DetailPokemonRouterProtocol {
        
        let router = DetailPokemonRouter()
        
        // assign vip
        var view: DetailPokemonViewProtocol = DetailPokemonViewController()
        
        var interactor: Interactor<
            Int,
            PokemonSpeciesDomainModel?,
            GetPokemonSpeciesRepository<
            PokemonSpeciesLocaleDataSource,
            PokemonSpeciesRemoteDataSource,
            PokemonSpeciesTransformer>>? = Injection().providePokemonSpecies()
        
//        var toggleFavoriteInteractor: Interactor<PokemonDomainModel, Bool, ToggleFavoritePokemonRepository<PokemonLocaleDataSource, PokemonTransformer>>? = Injection().provideFavorite()
        
        
        var presenter: DetailPresenterProtocol = DetailPresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.speciesInteractor = interactor
        presenter.toggleFavoriteInteractor = Injection().provideToggleFavorite()
        
        presenter.getPokemon(with: pokemon)
        router.entry = view as? DetailPokemonViewController
        
        return router
        
    }
    
}
