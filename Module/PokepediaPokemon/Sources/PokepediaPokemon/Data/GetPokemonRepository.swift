//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 26/08/23.
//

import Foundation
import RxSwift
import PokepediaCore

public struct GetPokemonRepository<
    PokemonLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
PokemonLocaleDataSource.Response == Transformer.Entity,
Transformer.Entity == PokemonEntity,
Transformer.Domain == PokemonDomainModel {
    public typealias Request = Int
    
    public typealias Response = Transformer.Domain
    
    private var _localeDataSource: PokemonLocaleDataSource
    private var _mapper: Transformer
    
    public func execute(request: Int?) -> Observable<Transformer.Domain> {
        guard let request = request else { fatalError() }
        
        return _localeDataSource.get(id: request)
            .map{ _mapper.transformEntityToDomain(entity: $0!) }
    }
    
}
