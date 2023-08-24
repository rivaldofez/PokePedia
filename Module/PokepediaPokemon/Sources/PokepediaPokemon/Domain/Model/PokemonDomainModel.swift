//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 24/08/23.
//

import Foundation

public struct PokemonDomainModel: Identifiable {
    public let id: Int
    public let name: String
    public let image: String
    public let height: Float
    public let weight: Float
    public let baseExp: Int
    public let baseStat: [BaseStat]
    public let moves: [String]
    public let type: [String]
    public let abilities: String
    public var isFavorite: Bool = false
}

public struct BaseStat {
    public let name: String
    public let effort: Int
    public let value: Int
    public let url: String
}

