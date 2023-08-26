//
//  FavoriteRouter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/08/23.
//

import UIKit
import PokepediaPokemon

protocol FavoriteRouterProtocol {
    var entry: FavoriteViewController? { get set }
    
    static func createFavorite() -> FavoriteRouterProtocol
    
    func gotoDetailPokemon(with pokemon: PokemonDomainModel )
}

class FavoriteRouter: FavoriteRouterProtocol {
    var entry: FavoriteViewController?
    
    static func createFavorite() -> FavoriteRouterProtocol {
        let router = FavoriteRouter()
    
        var view: FavoriteViewProtocol = FavoriteViewController()
        var presenter: FavoritePokemonPresenterProtocol = FavoritePokemonPresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.favoriteInteractor = Injection().provideFavorite()
        presenter.toggleFavoriteInteractor = Injection().provideToggleFavorite()
        
        router.entry = view as? FavoriteViewController
        
        return router
    }
    
    func gotoDetailPokemon(with pokemon: PokemonDomainModel) {
        let detailPokemonRouter = DetailPokemonRouter.createDetailPokemon(with: pokemon)
        guard let detailPokemonView = detailPokemonRouter.entry else { return }
        guard let viewController = self.entry else { return }
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(detailPokemonView, animated: true)
        viewController.hidesBottomBarWhenPushed = false
    }
}
