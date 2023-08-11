//
//  HomeUseCaseTests.swift
//  PokepediaTests
//
//  Created by Rivaldo Fernandes on 11/08/23.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking


@testable import Pokepedia
class HomeUseCaseTests: XCTestCase {
    
    var disposeBag: DisposeBag?
    var scheduler: ConcurrentDispatchQueueScheduler?
    var testScheduler: TestScheduler?
    var interactor: HomeUseCase?
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
        interactor = HomeInteractor(repository: MockPokemonRepository())
    }
    
    override func tearDown() {
        disposeBag = nil
        scheduler = nil
        testScheduler = nil
        super.tearDown()
    }
    
    
    func testGetPokemonDataPagination() throws {
        let actualData = DummyData.generateDummyPokemon(num: 10)
        let resultData = try interactor?.getPokemonDataPagination(offset: 10, limit: 10).toBlocking().first()
        
        XCTAssertEqual( resultData?.count , actualData.count)
        XCTAssertNotNil(resultData)
        XCTAssertEqual(resultData?.first?.id, actualData.first?.id)
    }
    
    func testGetPokemonDataPaginationEmpty() throws {
        let actualData = DummyData.generateDummyPokemon(num: 0)
        let resultData = try interactor?.getPokemonDataPagination(offset: 0, limit: 0).toBlocking().first()
        
        XCTAssertEqual( resultData?.count , 0)
        XCTAssertNotNil(resultData)
    }
}




