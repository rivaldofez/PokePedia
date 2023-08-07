//
//  PokemonModel.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct Pokemon: Identifiable{
    let id: Int
    let name: String
    let image: String
    let height: Float
    let weight: Float
    let baseExp: Int
    let baseStat: [BaseStat]
    let moves: [String]
    let type: [String]
    let abilities: String
    var isFavorite: Bool = false
}

struct BaseStat{
    let name: String
    let effort: Int
    let value: Int
    let url: String
}
