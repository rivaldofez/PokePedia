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

enum APIError: Error {
    case failedToGetData
}

class APIManager {
    static let shared = APIManager()
    
    
    func fetchListPokemon(completion: @escaping (Result<PokemonPageResponse, Error>) -> Void){
        guard let url = URL(string: "\(ConstantField.baseURL)pokemon/?offset=0&limit=50") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            print(String(data: data, encoding: .utf8) ?? "Error")
            
            do {
                let result = try JSONDecoder().decode(PokemonPageResponse.self, from: data)
                
                for pokemonItem in result.pokemonItem {
                    guard let specificUrl = URL(string: pokemonItem.url) else { return }
                    
                    let specificTask = URLSession.shared.dataTask(with: URLRequest(url: specificUrl)) { data, _, error in
                        
                        guard let pokemonDetail = data, error == nil else {
                            return
                        }
                        
                        print(String(data: pokemonDetail, encoding: .utf8) ?? "Error")
                    }
                    specificTask.resume()
                }
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
