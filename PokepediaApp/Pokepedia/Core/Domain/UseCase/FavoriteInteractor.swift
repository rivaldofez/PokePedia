//
//  FavoriteInteractor.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/08/23.
//

import Foundation
import RxSwift
import PokepediaPokemon

protocol FavoriteUseCase {
    func getFavoritePokemonList() -> Observable<[PokemonDomainModel]>
    func getSearchPokemon(query: String) -> Observable<[PokemonDomainModel]>
    func saveFavoritePokemon(pokemon: PokemonDomainModel) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: PokemonRepositoryProtocol
    
    required init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePokemonList() -> Observable<[PokemonDomainModel]> {
        return repository.getFavoritePokemonList()
    }
    
    func getSearchPokemon(query: String) -> Observable<[PokemonDomainModel]> {
        return repository.getSearchPokemon(query: query)
    }
    
    func saveFavoritePokemon(pokemon: PokemonDomainModel) -> Observable<Bool> {
        return repository.addPokemonFavorite(pokemon: pokemon)
    }
}
