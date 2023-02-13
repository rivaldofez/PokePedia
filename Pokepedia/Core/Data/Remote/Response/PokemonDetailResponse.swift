//
//  PokemonSpeciesResponse.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

//struct PokemonSpeciesResponse: Codable {
//    let baseExperience: Int
//
//
//    let height: Int
//
//    let id: Int
//    let isDefault: Bool
//    let locationAreaEncounters: String
//
//    let name: String
//    let order: Int
//
//
//    let weight: Int
//
//    enum CodingKeys: String, CodingKey {
//
//        case baseExperience = "base_experience"
//
//
//        case height
//
//        case id
//        case isDefault = "is_default"
//        case locationAreaEncounters = "location_area_encounters"
//        case  name, order
//
//        case  weight
//    }
//}


struct PokemonDetailResponse: Codable {
   let abilities: [Ability]
   let baseExperience: Int
   let forms: [Species]
   let gameIndices: [GameIndex]
   let height: Int
   let id: Int
   let isDefault: Bool
   let locationAreaEncounters: String
   let moves: [Move]
   let name: String
   let order: Int
   let species: Species
   let stats: [Stat]
   let types: [TypeElement]
   let weight: Int

   enum CodingKeys: String, CodingKey {
       case abilities
       case baseExperience = "base_experience"
       case forms
       case gameIndices = "game_indices"
       case height
       case id
       case isDefault = "is_default"
       case locationAreaEncounters = "location_area_encounters"
       case moves
       case name, order
       case species
       case stats
       case types
       case weight
   }
}

// MARK: - Ability
struct Ability: Codable {
   let ability: Species
   let isHidden: Bool
   let slot: Int

   enum CodingKeys: String, CodingKey {
       case ability
       case isHidden = "is_hidden"
       case slot
   }
}

// MARK: - Species
struct Species: Codable {
   let name: String
   let url: String
}

// MARK: - GameIndex
struct GameIndex: Codable {
   let gameIndex: Int
   let version: Species

   enum CodingKeys: String, CodingKey {
       case gameIndex = "game_index"
       case version
   }
}

// MARK: - Move
struct Move: Codable {
   let move: Species
   let versionGroupDetails: [VersionGroupDetail]

   enum CodingKeys: String, CodingKey {
       case move
       case versionGroupDetails = "version_group_details"
   }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
   let levelLearnedAt: Int
   let moveLearnMethod, versionGroup: Species

   enum CodingKeys: String, CodingKey {
       case levelLearnedAt = "level_learned_at"
       case moveLearnMethod = "move_learn_method"
       case versionGroup = "version_group"
   }
}

// MARK: - Stat
struct Stat: Codable {
   let baseStat, effort: Int
   let stat: Species

   enum CodingKeys: String, CodingKey {
       case baseStat = "base_stat"
       case effort, stat
   }
}

// MARK: - TypeElement
struct TypeElement: Codable {
   let slot: Int
   let type: Species
}
