//
//  MockGetPokemonSpeciesRepository.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 30/08/23.
//

import Foundation
import XCTest
import RxSwift
import PokepediaCore
import PokepediaPokemon
import PokepediaSpecies

struct MockGetPokemonSpeciesRepository: Repository {
    
    typealias Request = Int
    
    typealias Response = PokemonSpeciesDomainModel?
    
    func execute(request: Int?) -> RxSwift.Observable<PokepediaSpecies.PokemonSpeciesDomainModel?> {
        guard let id = request else { fatalError() }
        
        return Observable<PokemonSpeciesDomainModel?>.create { observer in
            observer.onNext(DummyData.generatePokemonSpecies(id: id))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    
}
