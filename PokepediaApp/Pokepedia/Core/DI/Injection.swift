//
//  Injection.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation
import RealmSwift
import PokepediaCore
import PokepediaSpecies
import PokepediaPokemon

final class Injection: NSObject {
    private let realm = try? Realm()
    
    func providePokemonSpecies<U: UseCase>() -> U where U.Request == Int, U.Response == PokemonSpeciesDomainModel {
        
        let locale = PokemonSpeciesLocaleDataSource(realm: realm!)
        let remote = PokemonSpeciesRemoteDataSource(endpoint: { Endpoints.Gets.pokemonSpecies($0).url })
        
        let mapper = PokemonSpeciesTransformer()
        
        let repository = GetPokemonSpeciesRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func providePokemon<U: UseCase>() -> U where U.Request == Int, U.Response == [PokemonDomainModel] {
        
        let locale = PokemonLocaleDataSource(realm: realm!)
        let remote = PokemonRemoteDataSource {
            Endpoints.Gets.pokemon($0).url
        }
        
        let mapper = PokemonsTransformer()
        
        let repository = GetPokemonRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    
    private func provideRepository() -> PokemonRepositoryProtocol {
        let realm = try? Realm()
    
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return PokemonRepository.sharedInstance(remote, locale)
    }
    
    func provideDetailPokemon() -> DetailPokemonUseCase {
        let repository = provideRepository()
        return DetailPokemonInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
}
