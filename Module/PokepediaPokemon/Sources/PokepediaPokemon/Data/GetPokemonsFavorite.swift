//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 26/08/23.
//

import Foundation
import RxSwift
import PokepediaCore

public struct GetFavoritePokemonsRepository<
    PokemonLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
PokemonLocaleDataSource.Response == PokemonEntity,
Transformer.Response == [PokemonItemResponse],
Transformer.Entity == [PokemonEntity],
Transformer.Domain == [PokemonDomainModel]
{
    
    private var _localeDataSource: FavoritePokemonLocaleDataSource
    private var _mapper: Transformer
    
    public init(
        localeDataSource: FavoritePokemonLocaleDataSource,
        mapper: Transformer
    ) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public typealias Request = String
    
    public typealias Response = [PokemonDomainModel]
    
    public func execute(request: String?) -> Observable<[PokemonDomainModel]> {
        guard let request = request else { fatalError() }
        
        return _localeDataSource.list(request: request)
            .map{ _mapper.transformEntityToDomain(entity: $0) }
    }
}
