//
//  DetailPokemonPresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import RxSwift

protocol DetailPokemonPresenterProtocol {
    var router: DetailPokemonRouterProtocol? { get set}
    var interactor: DetailPokemonUseCase? { get set }
    var view: DetailPokemonViewProtocol? { get set }
    
    var isLoadingData: Bool { get set}
    func getPokemonSpecies(id: Int)
}


class DetailPokemonPresenter: DetailPokemonPresenterProtocol {
    var router: DetailPokemonRouterProtocol?
    
    var interactor: DetailPokemonUseCase?
    
    var view: DetailPokemonViewProtocol?
    
    var isLoadingData: Bool = false
    
    private let disposeBag = DisposeBag()
    
    func getPokemonSpecies(id: Int) {
        isLoadingData = true
        
        interactor?.getPokemonSpecies(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{[weak self] pokemonSpeciesResult in
                
            } onError: { error in
              } onCompleted: {
                  self.isLoadingData = false
              }.disposed(by: disposeBag)
    }
    
    
}
