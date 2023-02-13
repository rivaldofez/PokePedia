//
//  PokemonMapper.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation

final class PokemonMapper {
    static func mapPokemonDetailResponsesToDomain(input pokemonDetailResponses: [PokemonDetailResponse]) -> [Pokemon]{
        
        return pokemonDetailResponses.map { result in
            let image = result.sprites.other.officialArtwork.frontDefault ??
            result.sprites.other.dreamWorld.frontDefault ??
            result.sprites.other.home.frontDefault ?? ""
            
            let newPokemon = Pokemon(
                id: result.id,
                name: result.name,
                image: image,
                height: result.height,
                weight: result.weight,
                baseExp: result.baseExperience,
                baseStat: result.stats.map { statResponse in
                    
                    let newBaseStat = BaseStat(
                        name: statResponse.stat.name,
                        effort: statResponse.effort,
                        value: statResponse.baseStat,
                        url: statResponse.stat.url)
                    
                    return newBaseStat
                    
                },
                moves: result.moves.map { moveResponse in
                    return moveResponse.move.name
                },
                type: result.types.map { typeResponse in
                    return typeResponse.type.name
                })
            
            return newPokemon
        }
    }

}
