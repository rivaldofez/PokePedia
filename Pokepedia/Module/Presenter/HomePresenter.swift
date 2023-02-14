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
    
    var offsetPagination: Int? { get set }
    var isLoadingData: Bool { get set }
    
    func getPokemonDataPagination(offset: Int, limit: Int)
    
    func didSelectPokemonItem(with pokemon: Pokemon)
}

class HomePresenter: HomePresenterProtocol{
    func didSelectPokemonItem(with pokemon: Pokemon) {
        print("select \(pokemon.name)")
    }
    
    var isLoadingData: Bool = false {
        didSet{
            if isLoadingData{
                view?.isLoadingData(with: true)
            }else{
                view?.isLoadingData(with: false)
            }
        }
    }
    
 
    var router: HomeRouterProtocol?
    
    var interactor: HomeUseCase? {
        didSet {
            offsetPagination = 0
        }
    }
    
    var offsetPagination: Int? {
        didSet {
            guard let offsetPagination = offsetPagination else { return }
            getPokemonDataPagination(offset: offsetPagination, limit: 50)
        }
    }
    
    var view: HomeViewProtocol?
    
    private let disposeBag = DisposeBag()

    func getPokemonDataPagination(offset: Int, limit: Int){
        isLoadingData = true
        
        interactor?.getPokemonDataPagination(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                
                self?.view?.updatePokemon(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemon(with: error.localizedDescription)
              } onCompleted: {
                  self.isLoadingData = false
              }.disposed(by: disposeBag)
    }
    
    
}
