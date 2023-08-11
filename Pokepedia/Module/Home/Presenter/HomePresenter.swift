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

class HomePresenter: HomePresenterProtocol {
    private let disposeBag = DisposeBag()
    
    var router: HomeRouterProtocol?
    var view: HomeViewProtocol?
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
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getPokemonDataPagination(offset: Int, limit: Int) {
        isLoadingData = true
        
        interactor?.getPokemonDataPagination(offset: offset, limit: limit)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResults in
                self?.view?.updatePokemon(with: pokemonResults)
            } onError: { error in
                self.view?.updatePokemon(with: error.localizedDescription)
                self.isLoadingData = false
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func didSelectPokemonItem(with pokemon: Pokemon) {
        router?.gotoDetailPokemon(with: pokemon)
    }
}
