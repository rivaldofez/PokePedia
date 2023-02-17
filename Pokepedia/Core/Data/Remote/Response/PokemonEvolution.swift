//
//  PokemonEvolution.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 17/02/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonSpeciesResponse = try? JSONDecoder().decode(PokemonSpeciesResponse.self, from: jsonData)

import Foundation

// MARK: - PokemonSpeciesResponse
struct PokemonEvolution: Codable {
    let babyTriggerItem: JSONNull?
    let chain: Chain
    let id: Int

    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain, id
    }
}

// MARK: - Chain
struct Chain: Codable {
    let evolutionDetails: [EvolutionDetail]
    let evolvesTo: [Chain]
    let isBaby: Bool
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let gender, heldItem, item, knownMove: JSONNull?
    let knownMoveType, location, minAffection, minBeauty: JSONNull?
    let minHappiness: JSONNull?
    let minLevel: Int
    let needsOverworldRain: Bool
    let partySpecies, partyType, relativePhysicalStats: JSONNull?
    let timeOfDay: String
    let tradeSpecies: JSONNull?
    let trigger: Species
    let turnUpsideDown: Bool

    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "held_item"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
