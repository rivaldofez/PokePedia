//
//  PokemonSpeciesResponse.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct PokemonSpeciesResponse: Codable {
    let baseExperience: Int


    let height: Int

    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String

    let name: String
    let order: Int

    
    let weight: Int

    enum CodingKeys: String, CodingKey {

        case baseExperience = "base_experience"


        case height

        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case  name, order

        case  weight
    }
}
