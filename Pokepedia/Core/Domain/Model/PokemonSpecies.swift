//
//  PokemonSpecies.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation

struct PokemonSpecies: Identifiable {
    let id: Int
    let baseHappines: Int
    let captureRate: Int
    let color: String
    let about: String
    let genderRate: Int
    let genus: String
    let growthRate: String
    let habitat: String
    let hatchCounter: Int
    let isLegendary: Bool
    let isMythical: Bool
    let isBaby: Bool
    let shape: String
}
