//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 24/08/23.
//

import Foundation
import PokepediaCore
import RxSwift

public struct GetPokemonRepository<
    PokemonLocaleDataSource: LocaleDataSource,
    PokemonRemoteDataSource: RemoteDataSource,
    Transformer: Mapper
>: Repository where
