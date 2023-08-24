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

class HomePokemonPresenter<
    GetPokemonInteractor: UseCase
>
where
GetPokemonInteractor.Request == Int,
GetPokemonInteractor.Response == [PokemonDomainModel] {
    
    var router: HomeRouterProtocol?
    var view: HomeViewProtocol?
    private let useCase: GetPokemonInteractor
    
    
    private let disposeBag = DisposeBag()
    
    init(useCase: GetPokemonInteractor) {
        self.useCase = useCase
    }
    
    var offsetPagination: Int? {
        didSet {
            guard let offsetPagination = offsetPagination else { return }
            //get pokemon data pagination
        }
    }
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getPokemonPagination(offset: Int) {
        isLoadingData = true
        
        useCase.execute(request: offset)
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
    
}
