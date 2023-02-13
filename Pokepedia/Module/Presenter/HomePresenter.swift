//
//  HomePresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import Foundation
import RxSwift

protocol HomePresenterProtocol {
    var router: HomeRouterProtocol? { get set}
    var interactor: HomeUseCase? { get set }
    var view: HomeViewProtocol? { get set }
    
    func getPokemonDataPagination(offset: Int, limit: Int)
}

class HomePresenter: HomePresenterProtocol{
 
    var router: HomeRouterProtocol?
    
    var interactor: HomeUseCase? {
        didSet {
            getPokemonDataPagination(offset: 0, limit: 50)
        }
    }
    
    var view: HomeViewProtocol?
    
    private let disposeBag = DisposeBag()

    func getPokemonDataPagination(offset: Int, limit: Int){
        view?.isLoadingData(with: true)
        
        interactor?.getPokemonDataPagination(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                
                self?.view?.updatePokemon(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemon(with: error.localizedDescription)
              } onCompleted: {
                  self.view?.isLoadingData(with: true)
              }.disposed(by: disposeBag)
    }
    
    
}
