//
//  RemoteDataSource.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 11/02/23.
//

import Foundation
import RxSwift
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonSpeciesResponse]>
}

final class RemoteDataSource: NSObject {
    private let disposeBag = DisposeBag()
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}


extension RemoteDataSource: RemoteDataSourceProtocol {
    private func getPokemonSource(offset: Int, limit: Int) -> Observable<PokemonPageResponse> {
        return Observable<PokemonPageResponse>.create { observer in
            if let url = URL(string: "\(Endpoints.Gets.pokemon.url)offset=\(offset)&limit=\(limit)") {
                AF.request(url)
                    .responseDecodable(of: PokemonPageResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                            
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    private func getPokemonSpecies(urlString: String) -> Observable<PokemonSpeciesResponse> {
        return Observable<PokemonSpeciesResponse>.create { observer in
            if let url = URL(string: urlString){
                AF.request(url)
                    .responseDecodable(of: PokemonSpeciesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getPokemonDataPagination(offset: Int, limit: Int) -> Observable<[PokemonSpeciesResponse]> {
        return Observable<[PokemonSpeciesResponse]>.create { observer in
            self.getPokemonSource(offset: offset, limit: limit).subscribe { pokemonPageResponses in
                var speciesObservables: [Observable<PokemonSpeciesResponse>] = []
                
                for item in pokemonPageResponses.pokemonItem {
                    speciesObservables.append(self.getPokemonSpecies(urlString: item.url))
                }
                
                Observable.zip(speciesObservables)
                    .subscribe { speciesResponses in
                        print(speciesResponses)
                        observer.onNext(speciesResponses)
                    } onError: { error in
                        print("error")
                      } onCompleted: {
                          observer.onCompleted()
                      }.disposed(by: self.disposeBag)
                
                
            } onError: { error in
                print("error")
              } onCompleted: {
                print("completed")
              }.disposed(by: self.disposeBag)
            
            return Disposables.create()
            
        }
    }
}
