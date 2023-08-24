//
//  HomePokemonPresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 24/08/23.
//

import Foundation
import PokepediaPokemon
import PokepediaCore
import RxSwift

protocol HomePokemonPresenterProtocol {
    var router: HomeRouterProtocol? { get set}
    var interactor: Interactor<
        Int,
        [PokemonDomainModel],
        GetPokemonRepository<
            PokemonLocaleDataSource,
            PokemonRemoteDataSource,
            PokemonsTransformer>>? { get set }
    var view: HomeViewProtocol? { get set }
    
    var offsetPagination: Int? { get set }
    var isLoadingData: Bool { get set }
    
    func getPokemonPagination(offset: Int)
    func didSelectPokemonItem(with pokemon: PokemonDomainModel)
}


class HomePokemonPresenter: HomePokemonPresenterProtocol {
    var interactor: Interactor<Int, [PokemonDomainModel], GetPokemonRepository<PokemonLocaleDataSource, PokemonRemoteDataSource, PokemonsTransformer>>? {
        didSet {
            offsetPagination = 0
        }
    }
    
    
    var router: HomeRouterProtocol?
    var view: HomeViewProtocol?
    
    private let disposeBag = DisposeBag()
    
    var offsetPagination: Int? {
        didSet {
            guard let offsetPagination = offsetPagination else { return }
            //get pokemon data pagination
            getPokemonPagination(offset: offsetPagination)
        }
    }
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getPokemonPagination(offset: Int) {
        isLoadingData = true
        
        interactor?.execute(request: offset)
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
    
    func didSelectPokemonItem(with pokemon: PokemonDomainModel) {
        router?.gotoDetailPokemon(with: pokemon)
    }
    
}
