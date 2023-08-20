//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 20/08/23.
//

import Foundation
import RealmSwift
import Core
import RxSwift

public struct ToggleFavoriteRepository<
    FavoriteLocalDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where FavoriteLocalDataSource.Response == Transformer.Entity,
Transformer.Entity == PokemonModuleEntity,
Transformer.Domain == PokemonDomainModel {
    public func execute(request: Transformer.Domain?) -> RxSwift.Observable<Bool> {
        
        guard let request = request else { fatalError() }
        return localeDataSource.update(entity: mapper.transformDomainToEntity(domain: request))
    }
    
    
    public typealias Request = Transformer.Domain
    
    public typealias Response = Bool
    
    private let localeDataSource: FavoriteLocalDataSource
    private let mapper: Transformer

    
    public init(
        localeDataSource: FavoriteLocalDataSource,
        mapper: Transformer
    ) {
        self.localeDataSource = localeDataSource
        self.mapper = mapper
    }
    
    
}
