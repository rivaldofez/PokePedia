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
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesResponse>
}

final class PokemonRepository: NSObject {
    typealias PokemonInstance = (RemoteDataSource) -> PokemonRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: PokemonInstance = { remoteDataSource in
        return PokemonRepository(remote: remoteDataSource)
        
    }
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[Pokemon]> {
        return self.remote.getPokemonDataPagination(offset: offset, limit: limit).map {
            PokemonMapper.mapPokemonDetailResponsesToDomain(input: $0)
        }
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesResponse> {
        return RemoteDataSource.sharedInstance.getPokemonSpecies(id: id)
    }
}
