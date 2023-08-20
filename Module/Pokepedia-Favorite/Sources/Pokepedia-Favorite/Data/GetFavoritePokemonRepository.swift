//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 20/08/23.
//

import Foundation
import Core
import RxSwift

public struct GetFavoritePokemonRepository<
    FavoriteLocalDataSource: LocaleDataSource,
    Transformer: Mapper > : Repository
where FavoriteLocalDataSource.Response == PokemonModuleEntity,
FavoriteLocalDataSource.Request == String,
Transformer.Entity == [PokemonModuleEntity],
Transformer.Domain == [PokemonDomainModel] {
    
    public typealias Request = FavoriteLocalDataSource.Request
    
    public typealias Response = [PokemonDomainModel]
    
    private let localeDataSource: FavoriteLocalDataSource
    private let mapper: Transformer
    
    
    public func execute(request: FavoriteLocalDataSource.Request?) -> RxSwift.Observable<[PokemonDomainModel]> {
        
        localeDataSource.list(request: request)
            .map { (self.mapper.transformEntityToDomain(entity: $0)) }
        
    }
    
}
    
