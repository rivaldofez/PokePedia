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
        case pokemonSpecies
        case pokemonEvolution
        
        var url: String {
            switch self {
            case .pokemonPagination: return "\(API.baseURL)pokemon/?"
            case .pokemonSpecies: return "\(API.baseURL)pokemon-species/"
            case .pokemonEvolution: return "\(API.baseURL)evolution-chain/"
            }
        }
    }
}
