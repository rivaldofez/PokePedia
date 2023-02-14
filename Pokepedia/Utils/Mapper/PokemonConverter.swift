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
            return "icon_bug"
        case .dark:
            return "icon_dark"
        case .dragon:
            return "icon_dragon"
        case .electric:
            return "icon_electric"
        case .fairy:
            return "icon_fairy"
        case .fighting:
            return "icon_fighting"
        case .fire:
            return "icon_fire"
        case .flying:
            return "icon_flying"
        case .ghost:
            return "icon_ghost"
        case .grass:
            return "icon_grass"
        case .ground:
            return "icon_ground"
        case .ice:
            return "icon_ice"
        case .normal:
            return "icon_normal"
        case .poison:
            return "icon_poison"
        case .psychic:
            return "icon_psychic"
        case .rock:
            return "icon_rock"
        case .steel:
            return "icon_steel"
        case .water:
            return "icon_water"
        }
    }
    
    static func typeStringToColorName(type: String) -> String {
        guard let pokemonElement = PokemonElement(rawValue: type) else { return "unknown"}
        switch pokemonElement {
        case .bug:
            return "color_bug"
        case .dark:
            return "color_dark"
        case .dragon:
            return "color_dragon"
        case .electric:
            return "color_electric"
        case .fairy:
            return "color_fairy"
        case .fighting:
            return "color_fighting"
        case .fire:
            return "color_fire"
        case .flying:
            return "color_flying"
        case .ghost:
            return "color_ghost"
        case .grass:
            return "color_grass"
        case .ground:
            return "color_ground"
        case .ice:
            return "color_ice"
        case .normal:
            return "color_normal"
        case .poison:
            return "color_poison"
        case .psychic:
            return "color_psychic"
        case .rock:
            return "color_rock"
        case .steel:
            return "color_steel"
        case .water:
            return "color_water"
        }
    }
}
