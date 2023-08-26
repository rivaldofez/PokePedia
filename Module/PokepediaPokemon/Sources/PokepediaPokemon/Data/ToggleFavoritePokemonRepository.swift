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
    
    private var _localeDataSource: PokemonLocaleDataSource
    private var _mapper: Transformer
    
    public init(
        localeDataSource: PokemonLocaleDataSource,
        mapper: Transformer
    ) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    
    public func execute(request: Transformer.Domain?) -> Observable<Bool> {
        guard let request = request else { fatalError() }
            return _localeDataSource.update(entity: _mapper.transformDomainToEntity(domain: request))
        
    }
}
