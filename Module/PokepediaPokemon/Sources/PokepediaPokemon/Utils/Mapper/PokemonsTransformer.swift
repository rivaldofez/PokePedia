//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 24/08/23.
//

import PokepediaCore
import RealmSwift

public struct PokemonsTransformer: Mapper {
    public typealias Response = [PokemonItemResponse]
    
    public typealias Entity = [PokemonEntity]
    
    public typealias Domain = [PokemonDomainModel]
    
    private let pokemonTransformer = PokemonTransformer()
    
    public init(){}
    
    public func transformResponseToEntity(response: [PokemonItemResponse]) -> [PokemonEntity] {
        return response.map {
            pokemonTransformer.transformResponseToEntity(response: $0)
        }
    }
    
    public func transformEntityToDomain(entity: [PokemonEntity]) -> [PokemonDomainModel] {
        return entity.map {
            pokemonTransformer.transformEntityToDomain(entity: $0)
        }
    }
    
    public func transformResponseToDomain(response: [PokemonItemResponse]) -> [PokemonDomainModel] {
        return response.map {
            pokemonTransformer.transformResponseToDomain(response: $0)
        }
    }
    
    public func transformDomainToEntity(domain: [PokemonDomainModel]) -> [PokemonEntity] {
        return domain.map {
            pokemonTransformer.transformDomainToEntity(domain: $0)
        }
    }
    
}
