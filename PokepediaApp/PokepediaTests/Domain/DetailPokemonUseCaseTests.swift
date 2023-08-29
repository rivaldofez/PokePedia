////
////  DetailPokemonUseCaseTests.swift
////  PokepediaTests
////
////  Created by Rivaldo Fernandes on 12/08/23.
////
//
//import XCTest
//import RxSwift
//import RxBlocking
//
//
//@testable import Pokepedia
//class DetailPokemonUseCaseTests: XCTestCase {
//    var interactor: DetailPokemonUseCase?
//    var repository = MockPokemonRepository()
//
//    override func setUp() {
//        super.setUp()
//        interactor = DetailPokemonInteractor(repository: repository)
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        interactor = nil
//    }
//
//
//    func testGetPokemonSpecies() throws {
//        let actualData = DummyData.generatePokemonSpecies(id: 0)
//        let resultData = try interactor?.getFavoritePokemonById(id: 0).toBlocking().first()!
//
//        XCTAssertNotNil(resultData)
//        XCTAssertEqual(resultData?.id, actualData.id)
//    }
//
//    func testGetFavoritePokemonById() throws {
//        let actualData = DummyData.generatePokemon(id: 0)
//        let resultData = try interactor?.getFavoritePokemonById(id: 0).toBlocking().first()!
//
//        XCTAssertNotNil(resultData)
//        XCTAssertEqual(resultData?.id, actualData.id)
//    }
//
//    func testSuccessSaveFavoritePokemon() throws {
//
//        repository.saveResult = true
//        let resultData = try interactor?.saveFavoritePokemon(pokemon: DummyData.generatePokemon(id: 0)).toBlocking().first()
//
//        XCTAssertEqual(resultData , true)
//        XCTAssertNotNil(resultData)
//    }
//
//    func testFailedSaveFavoritePokemon() throws {
//
//        repository.saveResult = false
//        let resultData = try interactor?.saveFavoritePokemon(pokemon: DummyData.generatePokemon(id: 0)).toBlocking().first()
//
//        XCTAssertEqual(resultData , false)
//        XCTAssertNotNil(resultData)
//    }
//
//}
