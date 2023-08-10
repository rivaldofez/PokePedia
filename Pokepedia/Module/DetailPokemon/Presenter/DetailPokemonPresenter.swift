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
    var detailPokemonView: DetailPokemonViewProtocol? { get set }
    
    var isLoadingData: Bool { get set}
    func getPokemonSpecies(id: Int)
    
    func getPokemon(with pokemon: Pokemon)
    
    func saveToggleFavorite(pokemon: Pokemon)
}

class DetailPokemonPresenter: DetailPokemonPresenterProtocol {
    func saveToggleFavorite(pokemon: Pokemon) {
        self.isLoadingData = true
        interactor?.saveFavoritePokemon(pokemon: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.detailPokemonView?.updateSaveToggleFavorite(with: result)
            } onError: { error in
                self.detailPokemonView?.updateSaveToggleFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func getPokemon(with pokemon: Pokemon) {
        isLoadingData = true
        
        interactor?.getFavoritePokemonById(id: pokemon.id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResult in
                if let pokemonResult = pokemonResult {
                    self?.detailPokemonView?.updatePokemon(with: pokemonResult)
                } else {
                    self?.detailPokemonView?.updatePokemon(with: pokemon)
                }
            } onError: { _ in
                self.detailPokemonView?.updatePokemon(with: pokemon)
                self.getPokemonSpecies(id: pokemon.id)
            } onCompleted: {
                self.getPokemonSpecies(id: pokemon.id)
            }.disposed(by: disposeBag)
    }
    
    var router: DetailPokemonRouterProtocol?
    
    var interactor: DetailPokemonUseCase?
    
    var detailPokemonView: DetailPokemonViewProtocol?
    
    var isLoadingData: Bool = false
    
    private let disposeBag = DisposeBag()
    
    func getPokemonSpecies(id: Int) {
        isLoadingData = true
        
        interactor?.getPokemonSpecies(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonSpeciesResult in
                self?.detailPokemonView?.updatePokemonSpecies(with: pokemonSpeciesResult)
            } onError: { error in
                self.detailPokemonView?.updatePokemonSpecies(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
}
