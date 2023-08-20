//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 18/08/23.
//

import Foundation
import Core
import RealmSwift
import RxSwift

public struct FavoriteLocalDataSource: LocaleDataSource {
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> RxSwift.Observable<[PokemonModuleEntity]> {
        return Observable<[PokemonModuleEntity]>.create { observer in
            if let request = request {
                let pokemonSearch: Results<PokemonModuleEntity> = {
                    _realm.objects(PokemonModuleEntity.self)
                        .where { $0.isFavorite }
                        .where { $0.name.contains(request, options: .caseInsensitive)}
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                
                observer.onNext(pokemonSearch.toArray(ofType: PokemonModuleEntity.self))
                observer.onCompleted()
            } else {
                let pokemons: Results<PokemonModuleEntity> = {
                    _realm.objects(PokemonModuleEntity.self)
                        .where { $0.isFavorite }
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                
                observer.onNext(pokemons.toArray(ofType: PokemonModuleEntity.self))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    public func update(entity: PokemonModuleEntity) -> RxSwift.Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try _realm.write {
                    _realm.add(entity, update: .all)
                }
                observer.onNext(entity.isFavorite)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    public func get(id: Int) -> RxSwift.Observable<PokemonModuleEntity?> {
        return Observable<PokemonModuleEntity?>.create { observer in
            let pokemons: Results<PokemonModuleEntity> = {
                _realm.objects(PokemonModuleEntity.self)
                    .where { $0.id == id }
            }()
            
            observer.onNext(pokemons.toArray(ofType: PokemonModuleEntity.self).first)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public typealias Request = String
    
    public typealias Response = PokemonModuleEntity
}
