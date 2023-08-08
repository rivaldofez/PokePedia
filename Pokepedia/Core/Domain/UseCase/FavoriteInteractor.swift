//
//  FavoriteInteractor.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/08/23.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoritePokemonList() -> Observable<[Pokemon]>
    
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: PokemonRepositoryProtocol
    
    required init(repository: PokemonRepositoryProtocol){
        self.repository = repository
    }
    
    func getFavoritePokemonList() -> Observable<[Pokemon]> {
        return repository.getFavoritePokemonList()
    }
}
