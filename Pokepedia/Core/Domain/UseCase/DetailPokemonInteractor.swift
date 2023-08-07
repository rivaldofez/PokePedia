//
//  DetailPokemonUseCase.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import RxSwift

protocol DetailPokemonUseCase {
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpecies>
    
    func getFavoritePokemonById(id: Int) -> Observable<Pokemon?>
    
    func saveFavoritePokemon(pokemon: Pokemon) -> Observable<Bool>
    
}

class DetailPokemonInteractor: DetailPokemonUseCase {
    private let repository: PokemonRepositoryProtocol
    
    required init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpecies> {
        return repository.getPokemonSpecies(id: id)
    }
    
    func getFavoritePokemonById(id: Int) -> Observable<Pokemon?> {
        return repository.getFavoritePokemonById(id: id)
    }
    
    func saveFavoritePokemon(pokemon: Pokemon) -> Observable<Bool> {
        return repository.addPokemonFavorite(pokemon: pokemon)
    }
}
