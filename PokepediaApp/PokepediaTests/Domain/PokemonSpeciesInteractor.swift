//
//  PokemonSpeciesInteractor.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 30/08/23.
//

import Foundation
import XCTest
import RxSwift
import RxBlocking
import PokepediaCore
import PokepediaPokemon
import PokepediaSpecies

@testable import Pokepedia
class PokemonSpeciesInteractor: XCTestCase {
    var interactor: Interactor<
        Int,
        PokemonSpeciesDomainModel?,
        MockGetPokemonSpeciesRepository>?
    
    func providePokemonSpecies<U: UseCase>() -> U where U.Request == Int, U.Response == PokemonSpeciesDomainModel? {
        let repository = MockGetPokemonSpeciesRepository()
        
        return Interactor(repository: repository) as! U
    }
    
    
    override func setUp() {
        super.setUp()
        
        interactor = providePokemonSpecies()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func testGetPokemonDataPagination() throws {
        let actualData = DummyData.generatePokemonSpecies(id: 100)
        let resultData = try interactor?.execute(request: 100).toBlocking().first()!
        
        
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.id, actualData.id)
        XCTAssertEqual(resultData?.about, actualData.about)
        XCTAssertEqual(resultData?.genus, actualData.genus)
        XCTAssertEqual(resultData?.color, actualData.color)
    }
    
}
