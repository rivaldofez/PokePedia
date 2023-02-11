//
//  APIManager.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation

struct ConstantField {
    static let baseURL = "https://pokeapi.co/api/v2/"
}

class APIManager {
    static let shared = APIManager()
    
    
    func fetchListPokemon(){
        guard let url = URL(string: "\(ConstantField.baseURL)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "Error")
        }
        task.resume()
    }
}
