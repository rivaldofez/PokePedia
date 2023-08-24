//
//  APICall.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct API {
    static let baseURL = "https://pokeapi.co/api/v2/"
}

protocol EndPoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: EndPoint {
        case pokemonPagination
        case pokemonSpeciess
        case pokemonSpecies(Int)
        case pokemon(Int)
        case pokemonEvolution
        
        var url: String {
            switch self {
            case .pokemonPagination: return "\(API.baseURL)pokemon/?"
            case let .pokemonSpecies(id): return "\(API.baseURL)pokemon-species/\(id)"
            case let .pokemon(offset): return "\(API.baseURL)pokemon/?offset=\(offset)&limit=\(50)"
            case .pokemonSpeciess: return "\(API.baseURL)pokemon-species/"
            case .pokemonEvolution: return "\(API.baseURL)evolution-chain/"
            }
        }
    }
}
