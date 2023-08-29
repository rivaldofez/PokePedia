//
//  ToggleFavoriteInteractorTests.swift
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
class ToggleFavoriteInteractorTests: XCTestCase {
    var interactor: Interactor<
        PokemonDomainModel,
        Bool,
        MockToggleFavoritePokemonRepository>?
    
    func provideToggleFavorite<U: UseCase>() -> U where U.Request == PokemonDomainModel, U.Response == Bool {
        
        var repository = MockToggleFavoritePokemonRepository()
        repository.saveResult = true
        
        return Interactor(repository: repository) as! U
    }
    
    override func setUp() {
        super.setUp()
        
        interactor = provideToggleFavorite()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func testToggleFavorite() throws {
        let resultData = try interactor?.execute(request: DummyData.generatePokemon(id: 0)).toBlocking().first()
                
                XCTAssertEqual(resultData , true)
                XCTAssertNotNil(resultData)
    }
            
            
    
}
