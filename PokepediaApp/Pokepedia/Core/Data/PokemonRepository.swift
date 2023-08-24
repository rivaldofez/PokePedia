//
//  PokemonRepository.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation
import RxSwift
import PokepediaPokemon
import PokepediaSpecies

protocol PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonDomainModel]>
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesDomainModel>
    
    func getFavoritePokemonList() -> Observable<[PokemonDomainModel]>
    
    func getSearchPokemon(query: String) -> Observable<[PokemonDomainModel]>
    
    func getFavoritePokemonById(id: Int) -> Observable<PokemonDomainModel?>
    
    func addPokemonFavorite(pokemon: PokemonDomainModel) -> Observable<Bool>
    
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
    func getFavoritePokemonById(id: Int) -> RxSwift.Observable<PokemonDomainModel?> {
        return self.locale.getFavoritePokemonById(id: id)
            .map { pokemonEntity in
                if let pokemonEntity {
                    return PokemonMapper.mapPokemonEntityToDomain(input: pokemonEntity)
                } else {
                    return nil
                }
            }
    }
    
    func getFavoritePokemonList() -> RxSwift.Observable<[PokemonDomainModel]> {
        return self.locale.getFavoritePokemonList()
            .map {
                PokemonMapper.mapPokemonEntitiesToDomain(input: $0)
            }
    }
    
    func getSearchPokemon(query: String) -> Observable<[PokemonDomainModel]> {
        return self.locale.getSearchPokemon(query: query)
            .map {
                PokemonMapper.mapPokemonEntitiesToDomain(input: $0)
            }
    }
    
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonDomainModel]> {
        return self.remote.getPokemonDataPagination(offset: offset, limit: limit).map {
            PokemonMapper.mapPokemonDetailResponsesToDomain(input: $0)
        }
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesDomainModel> {
        return self.remote.getPokemonSpecies(id: id).map {
            PokemonMapper.mapPokemonSpeciesResponseToDomain(input: $0)
        }
    }
    
    func addPokemonFavorite(pokemon: PokemonDomainModel) -> Observable<Bool> {
        return self.locale.saveToggleFavorite(from: PokemonMapper.mapPokemonToEntity(input: pokemon))
    }
}
