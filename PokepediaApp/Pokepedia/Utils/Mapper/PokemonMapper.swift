//
//  PokemonMapper.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation
import RealmSwift
import PokepediaSpecies

final class PokemonMapper {
    
    static func mapPokemonToEntity(input: Pokemon) -> PokemonEntity {
        let pokemonEntity = PokemonEntity()
        let baseStat = List<BaseStatEntity>()
        baseStat.append(
            objectsIn:
                input.baseStat.map {
                    let baseStatEntity = BaseStatEntity()
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
    }
    
    static func mapPokemonEntityToDomain(input: PokemonEntity) -> Pokemon {
        return Pokemon(
            id: input.id,
            name: input.name,
            image: input.image,
            height: input.height,
            weight: input.weight,
            baseExp: input.baseExp,
            baseStat: input.baseStat.map {
                return BaseStat(name: $0.name, effort: $0.effort, value: $0.value, url: $0.url)
            },
            moves: input.moves.components(separatedBy: ","),
            type: input.type.components(separatedBy: ","),
            abilities: input.abilities,
            isFavorite: input.isFavorite
        )
    }
    
    static func mapPokemonEntitiesToDomain(input: [PokemonEntity]) -> [Pokemon] {
        return input.map { result in
            return mapPokemonEntityToDomain(input: result)
        }
    }
    
    static func mapPokemonDetailResponsesToDomain(input pokemonDetailResponses: [PokemonDetailResponse]) -> [Pokemon] {
        
        return pokemonDetailResponses.map { result in
            let image = result.sprites.other.officialArtwork.frontDefault ??
            result.sprites.other.dreamWorld.frontDefault ??
            result.sprites.other.home.frontDefault ?? ""
            
            let newPokemon = Pokemon(
                id: result.id,
                name: result.name,
                image: image,
                height: Float(result.height) / 10.0,
                weight: Float(result.weight) / 10.0,
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
                },
                abilities: result.abilities.map { ability in
                    ability.ability.name.capitalized
                }.joined(separator: ", ")
                
            )
            
            return newPokemon
        }
    }
    
    static func mapPokemonSpeciesResponseToDomain(input pokemonSpeciesResponse: PokemonSpeciesResponse) -> PokemonSpecies {
        
        let aboutPokemon = {
            for flavorEntry in pokemonSpeciesResponse.flavorTextEntries
            where flavorEntry.language.name == "en" {
                return flavorEntry.flavorText
                    .replacingOccurrences(of: "\n", with: " ")
                    .utf8EncodedString()
                    .replacingOccurrences(of: "\\014", with: " ")
                    .utf8DecodedString()
            }
            
            return ""
        }()
        
        let genusPokemon = {
            for generaEntry in pokemonSpeciesResponse.genera
            where generaEntry.language.name == "en" {
                return generaEntry.genus.capitalized
            }
            
            return ""
        }()
        
        let eggGroup = pokemonSpeciesResponse.eggGroups.map { itemEgg in
            return itemEgg.name.capitalized
        }.joined(separator: ", ")
        
        let genderRate: String = {
            if pokemonSpeciesResponse.genderRate == -1 {
                return "Genderless"
            } else {
                let female = (Float(pokemonSpeciesResponse.genderRate) / 8.0) * 100
                let male = (Float(8 - pokemonSpeciesResponse.genderRate) / 8.0) * 100
                
                return "Male \(male)%, Female \(female)%"
            }
            
        }()
        
        let newPokemonSpecies = PokemonSpecies(
            id: pokemonSpeciesResponse.id,
            baseHappines: pokemonSpeciesResponse.baseHappiness,
            captureRate: pokemonSpeciesResponse.captureRate,
            color: pokemonSpeciesResponse.color.name,
            about: aboutPokemon,
            genderRate: genderRate,
            genus: genusPokemon,
            growthRate: pokemonSpeciesResponse.growthRate.name.capitalized,
            habitat: pokemonSpeciesResponse.habitat?.name.capitalized ?? "Unknown",
            hatchCounter: pokemonSpeciesResponse.hatchCounter,
            isLegendary: pokemonSpeciesResponse.isLegendary,
            isMythical: pokemonSpeciesResponse.isMythical,
            isBaby: pokemonSpeciesResponse.isBaby,
            shape: pokemonSpeciesResponse.shape.name,
            eggGroups: eggGroup
        )
        return newPokemonSpecies
    }
    
    static func mapPokemonDataToAboutSectionData(pokemon: Pokemon, pokemonSpecies: PokemonSpecies) -> [AboutCellModel] {
        var dataAboutCellModel: [AboutCellModel] = []
        
        var speciesItemCellModel: [ItemCellModel] = []
        speciesItemCellModel.append(ItemCellModel(title: "Genus", value: pokemonSpecies.genus))
        speciesItemCellModel.append(ItemCellModel(title: "Height", value: "\(pokemon.height) m"))
        speciesItemCellModel.append(ItemCellModel(title: "Weight", value: "\(pokemon.weight) kg"))
        speciesItemCellModel.append(ItemCellModel(title: "Abilities", value: pokemon.abilities))
        speciesItemCellModel.append(ItemCellModel(title: "Status", value: pokemonSpecies.isLegendary ? "Legendary" : pokemonSpecies.isMythical ? "Mythical" : "Common"))
        speciesItemCellModel.append(ItemCellModel(title: "Habitat", value: pokemonSpecies.habitat))
        let speciesCellModel = AboutCellModel(name: "Species", item: speciesItemCellModel)
        
        var physicalItemCellModel: [ItemCellModel] = []
        physicalItemCellModel.append(ItemCellModel(title: "Growth Rate", value: pokemonSpecies.growthRate))
        physicalItemCellModel.append(ItemCellModel(title: "Hatch Counter", value: String(pokemonSpecies.hatchCounter)))
        physicalItemCellModel.append(ItemCellModel(title: "Base Happines", value: String(pokemonSpecies.baseHappines)))
        physicalItemCellModel.append(ItemCellModel(title: "Base Experience", value: String(pokemon.baseExp)))
        physicalItemCellModel.append(ItemCellModel(title: "Capture Rate", value: String(pokemonSpecies.captureRate)))
        let physicalCellModel = AboutCellModel(name: "Physical", item: physicalItemCellModel)
        
        var breedingItemCellModel: [ItemCellModel] = []
        breedingItemCellModel.append(ItemCellModel(title: "Gender", value: pokemonSpecies.genderRate))
        breedingItemCellModel.append(ItemCellModel(title: "Egg Groups", value: pokemonSpecies.eggGroups))
        breedingItemCellModel.append(ItemCellModel(title: "Baby Pokemon", value: pokemonSpecies.isBaby ? "Yes" : "No"))
        let breedingCellModel = AboutCellModel(name: "Breeding", item: breedingItemCellModel)
        
        dataAboutCellModel.append(speciesCellModel)
        dataAboutCellModel.append(physicalCellModel)
        dataAboutCellModel.append(breedingCellModel)
        
        return dataAboutCellModel
    }
    
}
