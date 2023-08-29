//
//  MockToggleFavoritePokemonRepository.swift
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

struct MockToggleFavoritePokemonRepository: Repository {
    typealias Request = PokemonDomainModel
    
    typealias Response = Bool
    
    var saveResult = true
    
    func execute(request: PokemonDomainModel?) -> RxSwift.Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(self.saveResult)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
}
