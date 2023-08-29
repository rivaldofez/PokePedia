//
//  MockGetPokemonsRepository.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 29/08/23.
//

import Foundation
import XCTest
import RxSwift
import PokepediaCore
import PokepediaPokemon
import PokepediaSpecies

struct MockGetPokemonsRepository: Repository
{
    
    public typealias Request = Int
    
    public typealias Response = [PokemonDomainModel]
    
    public func execute(request: Int?) -> RxSwift.Observable<[PokemonDomainModel]> {
        guard let pagination = request else { fatalError() }
        return Observable<[PokemonDomainModel]>.create { observer in
            observer.onNext(DummyData.generateDummyPokemon(num: pagination))
            observer.onCompleted()

            return Disposables.create()
        }
    }
    
}
