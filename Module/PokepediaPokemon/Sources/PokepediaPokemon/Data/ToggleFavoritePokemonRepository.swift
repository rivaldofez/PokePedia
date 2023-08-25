//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 25/08/23.
//

import Foundation
import RxSwift
import PokepediaCore

public struct ToggleFavoritePokemonRepository<
    PokemonLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
PokemonLocaleDataSource.Response == Transformer.Entity,
Transformer.Entity == PokemonEntity,
Transformer.Domain == PokemonDomainModel {
    public typealias Request = Transformer.Domain
    
    public typealias Response = Bool
    
    private let localeDataSource: PokemonLocaleDataSource
    private let mapper: Transformer
    
    
    public func execute(request: Transformer.Domain?) -> Observable<Bool> {
        guard let request = request else { fatalError() }
            return localeDataSource.update(entity: mapper.transformDomainToEntity(domain: request))
        
    }
}
