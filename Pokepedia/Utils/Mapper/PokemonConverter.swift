//
//  PokemonConverter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation

final class PokemonConverter {
    
    enum PokemonElement: String {
        case bug = "bug"
        case dark = "dark"
        case dragon = "dragon"
        case electric = "electric"
        case fairy = "fairy"
        case fighting = "fighting"
        case fire = "fire"
        case flying = "flying"
        case ghost = "ghost"
        case grass = "grass"
        case ground = "ground"
        case ice = "ice"
        case normal = "normal"
        case poison = "poison"
        case psychic = "psychic"
        case rock = "rock"
        case steel = "steel"
        case water = "water"
    }
    
    static func typeStringToIconName(type: String) -> String {
        guard let pokemonElement = PokemonElement(rawValue: type) else { return "unknown"}
        switch pokemonElement {
        case .bug:
            return "bug"
        case .dark:
            return "dark"
        case .dragon:
            return "dragon"
        case .electric:
            return "electric"
        case .fairy:
            return "fairy"
        case .fighting:
            return "fighting"
        case .fire:
            return "fire"
        case .flying:
            return "flying"
        case .ghost:
            return "ghost"
        case .grass:
            return "grass"
        case .ground:
            return "ground"
        case .ice:
            return "ice"
        case .normal:
            return "normal"
        case .poison:
            return "poison"
        case .psychic:
            return "psychic"
        case .rock:
            return "rock"
        case .steel:
            return "steel"
        case .water:
            return "water"
        }
    }
}
