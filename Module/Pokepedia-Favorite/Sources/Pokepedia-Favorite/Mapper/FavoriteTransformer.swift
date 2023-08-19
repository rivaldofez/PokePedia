//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 19/08/23.
//

import Foundation
import Core
import RealmSwift

public struct FavoriteTransformer: Mapper {
    public func transformResponseToEntity(response: Response) -> PokemonModuleEntity? {
        return nil
    }
    
    public func transformResponseToDomain(response: Response) -> PokemonDomainModel? {
        return nil
    }
    
    public func transformEntityToDomain(entity: PokemonModuleEntity?) -> PokemonDomainModel? {
        
        if let input = entity {
            return PokemonDomainModel(
                id: input.id,
                name: input.name,
                image: input.image,
                height: input.height,
                weight: input.weight,
                baseExp: input.baseExp,
                baseStat: input.baseStat.map {
                    return BaseStatDomainModel(name: $0.name, effort: $0.effort, value: $0.value, url: $0.url)
                },
                moves: input.moves.components(separatedBy: ","),
                type: input.type.components(separatedBy: ","),
                abilities: input.abilities,
                isFavorite: input.isFavorite
                
            )
        } else {
            return nil
        }
    }
    
    public func transformDomainToEntity(domain: PokemonDomainModel?) -> PokemonModuleEntity? {
        
        if let input = domain {
            let pokemonEntity = PokemonModuleEntity()
            let baseStat = List<BaseStatModuleEntity>()
            baseStat.append(
                objectsIn:
                    input.baseStat.map {
                        let baseStatEntity = BaseStatModuleEntity()
                        baseStatEntity.name = $0.name
                        baseStatEntity.effort = $0.effort
                        baseStatEntity.url = $0.url
                        baseStatEntity.value = $0.value
                        return baseStatEntity
                    }
                
            )
            
            pokemonEntity.id = input.id
            pokemonEntity.name = input.name
            pokemonEntity.image = input.image
            pokemonEntity.height = input.height
            pokemonEntity.weight = input.weight
            pokemonEntity.baseExp = input.baseExp
            pokemonEntity.baseStat = baseStat
            pokemonEntity.moves = input.moves.joined(separator: ",")
            pokemonEntity.type = input.type.joined(separator: ",")
            pokemonEntity.abilities = input.abilities
            pokemonEntity.isFavorite = input.isFavorite
            
            return pokemonEntity
            
            
        } else {
            return nil
        }
        
    }
    
    public typealias Response = Any
    
    public typealias Entity = PokemonModuleEntity?
    
    public typealias Domain = PokemonDomainModel?
    

}
