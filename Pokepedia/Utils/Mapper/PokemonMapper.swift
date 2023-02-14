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
    
    static func mapPokemonSpeciesResponseToDomain(input pokemonSpeciesResponse: PokemonSpeciesResponse) -> PokemonSpecies {
        
        let aboutPokemon = {
            for flavorEntry in pokemonSpeciesResponse.flavorTextEntries {
                if flavorEntry.language.name == "en" {
                    return flavorEntry.flavorText
                }
            }
            return ""
        }()
        
        let genusPokemon = {
            for generaEntry in pokemonSpeciesResponse.genera {
                if generaEntry.language.name == "en" {
                    return generaEntry.genus
                }
            }
            return ""
        }()
        
        let newPokemonSpecies = PokemonSpecies(
            id: pokemonSpeciesResponse.id,
            baseHappines: pokemonSpeciesResponse.baseHappiness,
            captureRate: pokemonSpeciesResponse.captureRate,
            color: pokemonSpeciesResponse.color.name,
            about: aboutPokemon,
            genderRate: pokemonSpeciesResponse.genderRate,
            genus: genusPokemon,
            growthRate: pokemonSpeciesResponse.growthRate.name,
            habitat: pokemonSpeciesResponse.habitat.name,
            hatchCounter: pokemonSpeciesResponse.hatchCounter,
            isLegendary: pokemonSpeciesResponse.isLegendary,
            isMythical: pokemonSpeciesResponse.isMythical,
            isBaby: pokemonSpeciesResponse.isBaby,
            shape: pokemonSpeciesResponse.shape.name)
        
        return newPokemonSpecies
        
    }

}
