//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 26/08/23.
//

import Foundation
import PokepediaCore
import RealmSwift
import RxSwift

public struct FavoritePokemonLocaleDataSource: LocaleDataSource {
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> Observable<[PokemonEntity]>{
        return Observable<[PokemonEntity]>.create { observer in
            let pokeData: Results<PokemonEntity> = {
                _realm.objects(PokemonEntity.self)
                    .where { $0.isFavorite }
                    .sorted(byKeyPath: "id", ascending: true)
            }()
            if let request = request {
                if request.isEmpty {
                    observer.onNext(pokeData.toArray(ofType: PokemonEntity.self))
                } else {
                    let filteredData = pokeData.where { $0.name.contains(request, options: .caseInsensitive )}
                    
                    observer.onNext(filteredData.toArray(ofType: PokemonEntity.self))
                }
            } else {
                observer.onNext(pokeData.toArray(ofType: PokemonEntity.self))
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func inserts(entities: [PokemonEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try _realm.write {
                    for entity in entities {
                        _realm.add(entity, update: .all)
                    }
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    public func add(entity: PokemonEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try _realm.write {
                    _realm.add(entity, update: .all)
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    public func get(id: Int) -> RxSwift.Observable<PokemonEntity?> {
        return Observable<PokemonEntity?>.create { observer in
            let pokeList: Results<PokemonEntity> = {
                _realm.objects(PokemonEntity.self)
                    .where { $0.id == id }
            }()
            
            observer.onNext(pokeList.toArray(ofType: PokemonEntity.self).first)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func update(entity: PokemonEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            do {
                try _realm.write {
                    _realm.add(entity, update: .modified)
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    public typealias Request = String
    
    public typealias Response = PokemonEntity
    
    
}
