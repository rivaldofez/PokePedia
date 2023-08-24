//
//  HomeInteractior.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation
import RxSwift
import PokepediaPokemon

protocol HomeUseCase {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonDomainModel]>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: PokemonRepositoryProtocol
    
    required init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonDomainModel]> {
        return repository.getPokemonDataPagination(offset: offset, limit: limit)
    }
    
}
