//
//  PokemonModel.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct Pokemon: Identifiable{
    let id: Int // detail id
    let name: String // detail name
    let image: String //detail sprites
    let height: Int //detail height
    let weight: Int // detail weight
    let baseExp: Int // detail exp
    let baseStat: [BaseStat] //detail base stat
    let moves: [String] //detail moves
    let type: [String] //detail types
}


struct BaseStat{
    let name: String
    let effort: Int
    let value: Int
    let url: String
}
