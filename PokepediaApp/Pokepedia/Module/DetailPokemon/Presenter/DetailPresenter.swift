//
//  DetailPresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 25/08/23.
//

import Foundation
import PokepediaCore
import PokepediaPokemon
import PokepediaSpecies
import RxSwift

protocol DetailPresenterProtocol {
    var router: DetailPokemonRouterProtocol? { get set}
    var interactor: Interactor<
        Int,
        PokemonSpeciesDomainModel?,
        GetPokemonSpeciesRepository<
        PokemonSpeciesLocaleDataSource,
        PokemonSpeciesRemoteDataSource,
        PokemonSpeciesTransformer>>? { get set }
    
    var view: DetailPokemonViewProtocol? { get set }
    
    var isLoadingData: Bool { get set}
    
    func getPokemonSpecies(id: Int)
    func getPokemon(with pokemon: PokemonDomainModel)
    func saveToggleFavorite(pokemon: PokemonDomainModel)
}

class DetailPresenter: DetailPresenterProtocol {
    private let disposeBag = DisposeBag()
    
    
    var router: DetailPokemonRouterProtocol?
    
    var interactor: PokepediaCore.Interactor<Int, PokepediaSpecies.PokemonSpeciesDomainModel?, PokepediaSpecies.GetPokemonSpeciesRepository<PokepediaSpecies.PokemonSpeciesLocaleDataSource, PokepediaSpecies.PokemonSpeciesRemoteDataSource, PokepediaSpecies.PokemonSpeciesTransformer>>?
    
    var view: DetailPokemonViewProtocol?
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getPokemonSpecies(id: Int) {
        print("called get species presenter")
        isLoadingData = true
        
        interactor?.execute(request: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonSpeciesResult in                
                if let pokemonSpecies = pokemonSpeciesResult {
                    self?.view?.updatePokemonSpecies(with: pokemonSpecies)
                } else {
                    self?.view?.updatePokemonSpecies(with: "Cannot retrieve detail species pokemon")
                }
            } onError: { error in
                self.view?.updatePokemonSpecies(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
        
    }
    
    func getPokemon(with pokemon: PokemonDomainModel) {
        getPokemonSpecies(id: pokemon.id)
    }
    
    func saveToggleFavorite(pokemon: PokemonDomainModel) {
        
    }
}
