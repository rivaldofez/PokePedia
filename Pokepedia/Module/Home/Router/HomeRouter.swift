//
//  HomeRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 13/02/23.
//

import UIKit

typealias BeginPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol{
    var begin: BeginPoint? { get }
    
    static func start() -> HomeRouterProtocol
    
    func gotoDetailPokemon(with pokemon: Pokemon )
    
    func gotoProfile()
}

class HomeRouter: HomeRouterProtocol {
    var begin: BeginPoint?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        let interactor: HomeUseCase = Injection.init().provideHome()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.begin = view as? BeginPoint
        
        return router
    }
    
    func gotoDetailPokemon(with pokemon: Pokemon) {
        let detailPokemonRouter = DetailPokemonRouter.createDetailPokemon(with: pokemon)
        guard let detailPokemonView = detailPokemonRouter.entry else { return }
        guard let viewController = self.begin else { return }
        viewController.navigationController?.pushViewController(detailPokemonView, animated: true)
    }
    
    func gotoProfile() {
        let profileRouter = ProfileRouter.createProfile()
        guard let profileView = profileRouter.entry else { return }
        guard let viewController = self.begin else { return }
        
        viewController.navigationController?.pushViewController(profileView, animated: true)
    }
}
