//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 20/08/23.
//

import Foundation
import Core
import RealmSwift

public struct FavoritesTransformer: Mapper {
    private let favoriteTransformer = FavoriteTransformer()
    
    public func transformResponseToEntity(response: Response) -> [PokemonModuleEntity] {
        return []
    }
    
    public func transformResponseToDomain(response: Response) -> [PokemonDomainModel] {
        return []
    }
    
    public func transformEntityToDomain(entity: [PokemonModuleEntity]) -> [PokemonDomainModel] {
        entity.map { favoriteTransformer.transformEntityToDomain(entity: $0)! }
    }
    
    public func transformDomainToEntity(domain: [PokemonDomainModel]) -> [PokemonModuleEntity] {
        domain.map { favoriteTransformer.transformDomainToEntity(domain: $0)! }
    }
    
    public typealias Response = Any
    
    public typealias Entity = [PokemonModuleEntity]
    
    public typealias Domain = [PokemonDomainModel]
    
    
}
