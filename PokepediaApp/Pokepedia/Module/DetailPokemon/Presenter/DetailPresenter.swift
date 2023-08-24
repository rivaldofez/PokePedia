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
