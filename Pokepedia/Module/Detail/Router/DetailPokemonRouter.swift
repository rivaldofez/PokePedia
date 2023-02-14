//
//  DetailPokemonRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation

protocol DetailPokemonRouterProtocol {
    var entry: DetailPokemonViewController? { get }
    
    static func createDetailPokemon(with pokemon: Pokemon) -> DetailPokemonRouterProtocol
    
}

class DetailPokemonRouter: DetailPokemonRouterProtocol {
    var entry: DetailPokemonViewController?
    
    static func createDetailPokemon(with pokemon: Pokemon) -> DetailPokemonRouterProtocol {
        
        let router = DetailPokemonRouter()
        
        //assing vip
        var view: DetailPokemonViewProtocol = DetailPokemonViewController()
        
        var presenter: DetailPokemonPresenterProtocol = DetailPokemonPresenter()
        
        var interactor: DetailPokemonUseCase = Injection.init().provideDetailPokemon()
        
        
        return router
        
        
    }
    
}
