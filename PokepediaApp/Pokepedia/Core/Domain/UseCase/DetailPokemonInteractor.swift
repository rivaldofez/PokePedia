//
//  DetailPokemonUseCase.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import RxSwift
import PokepediaPokemon
import PokepediaSpecies

protocol DetailPokemonUseCase {
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesDomainModel>
    
    func getFavoritePokemonById(id: Int) -> Observable<PokemonDomainModel?>
    
    func saveFavoritePokemon(pokemon: PokemonDomainModel) -> Observable<Bool>
    
}

class DetailPokemonInteractor: DetailPokemonUseCase {
    private let repository: PokemonRepositoryProtocol
    
    required init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesDomainModel> {
        return repository.getPokemonSpecies(id: id)
    }
    
    func getFavoritePokemonById(id: Int) -> Observable<PokemonDomainModel?> {
        return repository.getFavoritePokemonById(id: id)
    }
    
    func saveFavoritePokemon(pokemon: PokemonDomainModel) -> Observable<Bool> {
        return repository.addPokemonFavorite(pokemon: pokemon)
    }
}
