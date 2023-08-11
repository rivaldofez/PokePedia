//
//  FavoriteRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/08/23.
//

import UIKit

protocol FavoriteRouterProtocol {
    var entry: FavoriteViewController? { get set }
    
    static func createFavorite() -> FavoriteRouterProtocol
    
    func gotoDetailPokemon(with pokemon: Pokemon )
}

class FavoriteRouter: FavoriteRouterProtocol {
    var entry: FavoriteViewController?
    
    static func createFavorite() -> FavoriteRouterProtocol {
        let router = FavoriteRouter()
    
        var view: FavoriteViewProtocol = FavoriteViewController()
        var presenter: FavoritePresenterProtocol = FavoritePresenter()
        let interactor: FavoriteUseCase = Injection.init().provideFavorite()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? FavoriteViewController
        
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
