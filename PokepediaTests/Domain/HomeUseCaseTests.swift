//
//  HomeUseCaseTests.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 11/08/23.
//

import XCTest
import RxSwift
import RxBlocking


@testable import Pokepedia
class HomeUseCaseTests: XCTestCase {
    
    var interactor: HomeUseCase?
    
    override func setUp() {
        super.setUp()
        interactor = HomeInteractor(repository: MockPokemonRepository())
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    
    func testGetPokemonDataPagination() throws {
        let actualData = DummyData.generateDummyPokemon(num: 10)
        let resultData = try interactor?.getPokemonDataPagination(offset: 10, limit: 10).toBlocking().first()
        
        XCTAssertEqual( resultData?.count , actualData.count)
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.first?.id, actualData.first?.id)
    }
    
    func testGetPokemonDataPaginationEmpty() throws {
        let resultData = try interactor?.getPokemonDataPagination(offset: 0, limit: 0).toBlocking().first()
        
        XCTAssertEqual( resultData?.count , 0)
        XCTAssertNotNil(resultData)
    }
}




