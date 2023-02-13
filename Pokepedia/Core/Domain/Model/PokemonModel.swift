//
//  PokemonModel.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct PokemonModel: Identifiable{
    let id: String // detail id
    let name: String // detail name
    let image: String //detail sprites
    let height: Double //detail height
    let weight: Double // detail weight
    let baseExp: Int // detail exp
    let baseStat: [BaseStat] //detail base stat
    let moves: [String] //detail moves
    let type: [String] //detail types
    let color: String // species
    let base_happines: Int //species
    let captureRate: Int //species
}


struct BaseStat{
    let name: String
    let effort: Int
    let value: Int
    let url: String
}
