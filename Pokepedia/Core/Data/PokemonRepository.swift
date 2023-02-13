//
//  PokemonRepository.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation
import RxSwift

protocol PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) ->  Observable<[PokemonDetailResponse]>
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesResponse>
}

final class PokemonRepository: NSObject {
    typealias PokemonInstance = (RemoteDataSource) -> PokemonRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let shared: PokemonInstance = { remoteDataSource in
        return PokemonRepository(remote: remoteDataSource)
        
    }
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonDetailResponse]> {
        return RemoteDataSource.sharedInstance.getPokemonDataPagination(offset: offset, limit: limit)
    }
    
    func getPokemonSpecies(id: Int) -> Observable<PokemonSpeciesResponse> {
        return RemoteDataSource.sharedInstance.getPokemonSpecies(id: id)
    }
}
