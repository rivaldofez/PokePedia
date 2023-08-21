//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 22/08/23.
//

import Foundation

struct PokemonSpeciesResponse: Codable {
    let baseHappiness: Int
    let captureRate: Int
    let color: BridgeComponent
    let eggGroups: [BridgeComponent]
    let flavorTextEntries: [FlavorTextEntry]
    let genderRate: Int
    let genera: [Genus]
    let growthRate: BridgeComponent
    let habitat: BridgeComponent?
    let hatchCounter: Int
    let id: Int
    let isBaby, isLegendary, isMythical: Bool
    let name: String
    let shape: BridgeComponent
    let varieties: [Variety]
    
    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
        case genderRate = "gender_rate"
        case genera
        case growthRate = "growth_rate"
        case habitat
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case name
        case shape, varieties
    }
}

struct EvolutionChain: Codable {
    let url: String
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, version: BridgeComponent
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}

struct Genus: Codable {
    let genus: String
    let language: BridgeComponent
}

struct Name: Codable {
    let language: BridgeComponent
    let name: String
}

struct PalParkEncounter: Codable {
    let area: BridgeComponent
    let baseScore, rate: Int
    
    enum CodingKeys: String, CodingKey {
        case area
        case baseScore = "base_score"
        case rate
    }
}

struct PokedexNumber: Codable {
    let entryNumber: Int
    let pokedex: BridgeComponent
    
    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

struct Variety: Codable {
    let isDefault: Bool
    let pokemon: BridgeComponent
    
    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}

struct BridgeComponent: Codable {
    let name: String
    let url: String
}
