//
//  Injection.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> PokemonRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return PokemonRepository.sharedInstance(remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
}
