//
//  PokemonRepository.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation
import RxSwift

protocol PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) ->  Observable<[PokemonSpeciesResponse]>
}

final class PokemonRepository: NSObject {
//    typealias PokemonInstance = (RemoteDataSource) -> PokemonRepository
//
//    fileprivate let remote: RemoteDataSource
//
//    private init(remote: RemoteDataSource){
//        self.remote = remote
//    }
//
//    static let sharedInstance: PokemonInstance = { remoteRepo in
//        return PokemonRepository(remote: remoteRepo)
//
//    }
    static let shared = PokemonRepository()
    
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonSpeciesResponse]> {
        return RemoteDataSource.sharedInstance.getPokemonDataPagination(offset: offset, limit: limit)
    }
}
