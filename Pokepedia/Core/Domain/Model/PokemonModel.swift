//
//  PokemonModel.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct Pokemon: Identifiable{
    let id: String
    let name: String
    let image: String
    let height: Double
    let weight: Double
    let baseExp: Int
    let baseStat: [BaseStat]
    let moves: [String]
    let type: [String]
    let color: String
    let base_happines: Int
    let captureRate: Int
}


struct BaseStat{
    let name: String
    let effort: Int
    let value: Int
    let url: String
}
