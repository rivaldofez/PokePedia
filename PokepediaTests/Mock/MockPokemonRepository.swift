//
//  MockPokemonRepository.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 12/08/23.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import Pokepedia

class MockPokemonRepository: PokemonRepositoryProtocol {
    var numResult = 0
    var saveResult = true
    
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[Pokemon]> {
        return Observable<[Pokemon]>.create { observer in
            observer.onNext(DummyData.generateDummyPokemon(num: limit))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpecies> {
        return Observable<PokemonSpecies>.create { observer in
            observer.onNext(DummyData.generatePokemonSpecies(id: id))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getFavoritePokemonList() -> Observable<[Pokemon]> {
        return Observable<[Pokemon]>.create { observer in
            observer.onNext(DummyData.generateDummyPokemon(num: self.numResult))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getSearchPokemon(query: String) -> Observable<[Pokemon]> {
        return Observable<[Pokemon]>.create { observer in
            observer.onNext(DummyData.generateDummyPokemon(num: self.numResult))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getFavoritePokemonById(id: Int) -> Observable<Pokemon?> {
        return Observable<Pokemon?>.create { observer in
            observer.onNext(DummyData.generatePokemon(id: id))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func addPokemonFavorite(pokemon: Pokemon) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(self.saveResult)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
