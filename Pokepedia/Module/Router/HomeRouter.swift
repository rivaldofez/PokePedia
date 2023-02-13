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
}

class HomeRouter: HomeRouterProtocol {
    var begin: BeginPoint?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        //assign vip
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        var interactor: HomeUseCase = Injection.init().provideHome()
        
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.begin = view as? BeginPoint
        
        
        return router
    }
    
    
}
