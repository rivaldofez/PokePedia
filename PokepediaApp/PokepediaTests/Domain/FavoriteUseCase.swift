//
//  FavoriteUseCase.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 12/08/23.
//

import XCTest
import RxSwift
import RxBlocking


@testable import Pokepedia
class FavoriteUseCaseTests: XCTestCase {
    var interactor: FavoriteUseCase?
    var repository = MockPokemonRepository()
    
    override func setUp() {
        super.setUp()
        interactor = FavoriteInteractor(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func testSuccessGetFavoritePokemonList() throws {
        //num 10 defined in Mock Repository as Dummy Data
        let actualData = DummyData.generateDummyPokemon(num: 10)
        repository.numResult = 10
        let resultData = try interactor?.getFavoritePokemonList().toBlocking().first()
        
        XCTAssertEqual( resultData?.count , actualData.count)
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.first?.id, actualData.first?.id)
    }
    
    func testEmptyGetFavoritePokemonList() throws {
        //num 10 defined in Mock Repository as Dummy Data
        repository.numResult = 0
        let resultData = try interactor?.getFavoritePokemonList().toBlocking().first()
        
        XCTAssertEqual( resultData?.count , 0)
        XCTAssertNotNil(resultData)
    }

    func testSuccessGetSearchFavoritePokemon() throws {
        let actualData = DummyData.generateDummyPokemon(num: 10)
        repository.numResult = 10
        let resultData = try interactor?.getSearchPokemon(query: "dummy-query").toBlocking().first()
        
        XCTAssertEqual( resultData?.count , actualData.count)
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.first?.id, actualData.first?.id)
    }

    func testEmptyGetSearchFavoritePokemon() throws {
        repository.numResult = 0
        let resultData = try interactor?.getSearchPokemon(query: "dummy-query").toBlocking().first()
        
        XCTAssertEqual( resultData?.count , 0)
        XCTAssertNotNil(resultData)
    }

    func testSuccessSaveFavoritePokemon() throws {
        
        repository.saveResult = true
        let resultData = try interactor?.saveFavoritePokemon(pokemon: DummyData.generatePokemon(id: 0)).toBlocking().first()
        
        XCTAssertEqual(resultData , true)
        XCTAssertNotNil(resultData)
    }
    
    func testFailedSaveFavoritePokemon() throws {
        
        repository.saveResult = false
        let resultData = try interactor?.saveFavoritePokemon(pokemon: DummyData.generatePokemon(id: 0)).toBlocking().first()
        
        XCTAssertEqual(resultData , false)
        XCTAssertNotNil(resultData)
    }
}
