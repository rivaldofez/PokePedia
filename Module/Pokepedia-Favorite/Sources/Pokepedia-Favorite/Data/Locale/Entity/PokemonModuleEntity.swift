//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 18/08/23.
//

import Foundation
import RealmSwift

public class PokemonModuleEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var height: Float
    @Persisted var weight: Float
    @Persisted var baseExp: Int
    @Persisted var baseStat: List<BaseStatModuleEntity>
    @Persisted var moves: String
    @Persisted var type: String
    @Persisted var abilities: String
    @Persisted var isFavorite: Bool
}

public class BaseStatModuleEntity: Object {
    @Persisted var name: String
    @Persisted var effort: Int
    @Persisted var value: Int
    @Persisted var url: String
}

