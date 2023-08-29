//
//  PokemonsInteractor.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 29/08/23.
//

import Foundation
import XCTest
import RxSwift
import RxBlocking
import PokepediaCore
import PokepediaPokemon

@testable import Pokepedia
class PokemonsInteractorTests: XCTestCase {
    var interactor: Interactor<Int, [PokemonDomainModel], MockGetPokemonsRepository>?
    
    func providePokemons<U: UseCase>() -> U where U.Request == Int, U.Response == [PokemonDomainModel] {
        let repository = MockGetPokemonsRepository()
        
        return Interactor(repository: repository) as! U
    }
    
    
    override func setUp() {
        super.setUp()
        
        interactor = providePokemons()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func testGetPokemonDataPagination() throws {
        let actualData = DummyData.generateDummyPokemon(num: 10)
        let resultData = try interactor?.execute(request: 10).toBlocking().first()
        
        XCTAssertEqual( resultData?.count , actualData.count)
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.first?.id, actualData.first?.id)
    }
    
}
