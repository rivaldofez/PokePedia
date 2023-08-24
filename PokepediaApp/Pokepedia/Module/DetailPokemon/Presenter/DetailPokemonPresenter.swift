//
//  DetailPokemonPresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 14/02/23.
//

import Foundation
import RxSwift
import PokepediaPokemon

protocol DetailPokemonPresenterProtocol {
    var router: DetailPokemonRouterProtocol? { get set}
    var interactor: DetailPokemonUseCase? { get set }
    var view: DetailPokemonViewProtocol? { get set }
    
    var isLoadingData: Bool { get set}
    
    func getPokemonSpecies(id: Int)
    func getPokemon(with pokemon: PokemonDomainModel)
    func saveToggleFavorite(pokemon: PokemonDomainModel)
}

class DetailPokemonPresenter: DetailPokemonPresenterProtocol {
    private let disposeBag = DisposeBag()
    
    var router: DetailPokemonRouterProtocol?
    var view: DetailPokemonViewProtocol?
    var interactor: DetailPokemonUseCase?
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getPokemonSpecies(id: Int) {
        isLoadingData = true
        
        interactor?.getPokemonSpecies(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonSpeciesResult in
                self?.view?.updatePokemonSpecies(with: pokemonSpeciesResult)
            } onError: { error in
                self.view?.updatePokemonSpecies(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func saveToggleFavorite(pokemon: PokemonDomainModel) {
        self.isLoadingData = true
        interactor?.saveFavoritePokemon(pokemon: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.view?.updateSaveToggleFavorite(with: result)
            } onError: { error in
                self.view?.updateSaveToggleFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func getPokemon(with pokemon: PokemonDomainModel) {
        isLoadingData = true
        
        interactor?.getFavoritePokemonById(id: pokemon.id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResult in
                if let pokemonResult = pokemonResult {
                    self?.view?.updatePokemon(with: pokemonResult)
                } else {
                    self?.view?.updatePokemon(with: pokemon)
                }
            } onError: { _ in
                self.view?.updatePokemon(with: pokemon)
                self.getPokemonSpecies(id: pokemon.id)
            } onCompleted: {
                self.getPokemonSpecies(id: pokemon.id)
            }.disposed(by: disposeBag)
    }
}
