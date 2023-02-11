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
        case pokemon
        
        
        var url: String {
            switch self {
            case .pokemon: return "\(API.baseURL)pokemon/?offset=0&limit=50"
            }
        }
    }
}
