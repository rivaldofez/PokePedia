//
//  HomePresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation

protocol HomePresenterProtocol {
    var router: HomeRouterProtocol? { get set}
    var interactor: HomeUseCase? { get set }
    var view: HomeViewProtocol? { get set }
    
    func didGetPokemonData(with result: Result<[Pokemon], Error>)
}

class HomePresenter: HomePresenterProtocol{
    var router: HomeRouterProtocol?
    
    var interactor: HomeUseCase?
    
    var view: HomeViewProtocol?
    
    func didGetPokemonData(with result: Result<[Pokemon], Error>) {
        switch result {
        case .success(let pokemons):
            view?.updatePokemon(with: pokemons)
        case .failure(let error):
            view?.updatePokemon(with: error.localizedDescription)
        }
    }
    
    
}
