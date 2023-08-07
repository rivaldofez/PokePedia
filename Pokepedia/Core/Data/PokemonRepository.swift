//
//  PokemonRepository.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation
import RxSwift

protocol PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) ->  Observable<[Pokemon]>
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpecies>
    
    func getFavoritePokemonList() -> Observable<[Pokemon]>
    
    func getFavoritePokemonById(id: Int) -> Observable<Pokemon?>
    
    func addPokemonFavorite(pokemon: Pokemon) -> Observable<Bool>
    
    
}

final class PokemonRepository: NSObject {
    typealias PokemonInstance = (RemoteDataSource, LocaleDataSource) -> PokemonRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: PokemonInstance = { remoteDataSource, localeDataSource in
        return PokemonRepository(remote: remoteDataSource, locale: localeDataSource)
        
    }
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getFavoritePokemonById(id: Int) -> RxSwift.Observable<Pokemon?> {
        return self.locale.getFavoritePokemonById(id: id)
            .map { pokemonEntity in
                if let pokemonEntity {
                    return PokemonMapper.mapPokemonEntityToDomain(input: pokemonEntity)
                } else {
                    return nil
                }
            }
    }
    
    func getFavoritePokemonList() -> RxSwift.Observable<[Pokemon]> {
        return self.locale.getFavoritePokemonList()
            .map {
                PokemonMapper.mapPokemonEntitiesToDomain(input: $0)
            }
    }
    
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[Pokemon]> {
        return self.remote.getPokemonDataPagination(offset: offset, limit: limit).map {
            PokemonMapper.mapPokemonDetailResponsesToDomain(input: $0)
        }
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpecies> {
        return self.remote.getPokemonSpecies(id: id).map {
            PokemonMapper.mapPokemonSpeciesResponseToDomain(input: $0)
        }
    }
    
    func addPokemonFavorite(pokemon: Pokemon) -> Observable<Bool> {
        return self.locale.addPokemonFavorite(from: PokemonMapper.mapPokemonToEntity(input: pokemon))
    }
}
