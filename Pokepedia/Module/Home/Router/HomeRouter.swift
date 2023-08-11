//
//  HomeRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import UIKit

typealias EntryPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func start() -> HomeRouterProtocol
    
    func gotoDetailPokemon(with pokemon: Pokemon )
}

class HomeRouter: HomeRouterProtocol {
    var entry: EntryPoint?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        let interactor: HomeUseCase = Injection.init().provideHome()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func gotoDetailPokemon(with pokemon: Pokemon) {
        let detailPokemonRouter = DetailPokemonRouter.createDetailPokemon(with: pokemon)
        guard let detailPokemonView = detailPokemonRouter.entry else { return }
        guard let viewController = self.entry else { return }
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailPokemonView, animated: true)
        viewController.hidesBottomBarWhenPushed = false
    }
}
