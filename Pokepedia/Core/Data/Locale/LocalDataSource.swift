//
//  LocalDataSource.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 02/08/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func getFavoritePokemonList() -> Observable<[PokemonEntity]>
    func addPokemonFavorite(from pokemon: PokemonEntity) -> Observable<Bool>
    
    func getFavoritePokemonById(id: Int) -> Observable<PokemonEntity?>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavoritePokemonById(id: Int) -> RxSwift.Observable<PokemonEntity?> {
        return Observable<PokemonEntity?>.create { observer in
            if let realm = self.realm {
                let pokemons: Results<PokemonEntity> = {
                    realm.objects(PokemonEntity.self)
                        .where { $0.id == id }
                }()
                
                observer.onNext(pokemons.toArray(ofType: PokemonEntity.self).first)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
                print("error database instance")
            }
            
            return Disposables.create()
        }
    }
    
    func getFavoritePokemonList() -> RxSwift.Observable<[PokemonEntity]> {
        return Observable<[PokemonEntity]>.create { observer in
            if let realm = self.realm {
                let pokemons: Results<PokemonEntity> = {
                    realm.objects(PokemonEntity.self)
                        .where{ $0.isFavorite }
                }()
                observer.onNext(pokemons.toArray(ofType: PokemonEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
    
    func addPokemonFavorite(from pokemon: PokemonEntity) -> RxSwift.Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(pokemon, update: .all)
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}

