//
//  DetailPokemonRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import PokepediaPokemon

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
        
        var presenter: DetailPokemonPresenterProtocol = DetailPokemonPresenter()
        
        let interactor: DetailPokemonUseCase = Injection.init().provideDetailPokemon()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        presenter.getPokemon(with: pokemon)
        router.entry = view as? DetailPokemonViewController
        
        return router
        
    }
    
}
