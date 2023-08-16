//
//  DummyData.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 11/08/23.
//

import XCTest


@testable import Pokepedia
final class DummyData {
    static func generateDummyBaseStat() -> [BaseStat] {
        var listBaseStat = [BaseStat]()
        for i in 0..<6 {
            let baseStat = BaseStat(
                name: "Base Stat-\(i)",
                effort: i,
                value: i,
                url: "Url-\(i)")
            listBaseStat.append(baseStat)
        }
        return listBaseStat
    }
    
    static func generateDummyMoves(num: Int) -> [String] {
        var listMoves = [String]()
        for i in 0..<6 {
            listMoves.append("Move-\(i)")
        }
        return listMoves
    }
    
    static func generateDummyTypes(num: Int) -> [String] {
        var listTypes = [String]()
        for i in 0..<6 {
            listTypes.append("Type-\(i)")
        }
        return listTypes
    }
    
    
    static func generateDummyPokemon(num: Int) -> [Pokemon] {
        var pokemons = [Pokemon]()
        for i in 0..<num {
            pokemons.append(
                DummyData.generatePokemon(id: i)
            )
        }
        
        return pokemons
    }
    
    static func generatePokemon(id: Int) -> Pokemon {
        return Pokemon(
            id: id,
            name: "Name Pokemon-\(id)",
            image: "Image Pokemon-\(id)",
            height: Float(id),
            weight: Float(id),
            baseExp: id,
            baseStat: generateDummyBaseStat(),
            moves: generateDummyMoves(num: id),
            type: generateDummyTypes(num: id),
            abilities: "Ability Pokemon-\(id)")
    }
    
    static func generatePokemonSpecies(id: Int) -> PokemonSpecies {
        return PokemonSpecies(
            id: id,
            baseHappines: 0,
            captureRate: 0,
            color: "dummy-color-\(id)",
            about: "dummy-about-\(id)",
            genderRate: "dummy-gender-rate-\(id)",
            genus: "dummy-genus-\(id)",
            growthRate: "dummy-growth-rate-\(id)",
            habitat: "dummy-habitat-\(id)",
            hatchCounter: 0,
            isLegendary: false,
            isMythical: false,
            isBaby: false,
            shape: "dummy-shape-\(id)",
            eggGroups: "dummy-egggroup-\(id)")
    }
}
