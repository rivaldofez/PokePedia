//
//  ProfilePresenter.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 29/07/23.
//

import Foundation

protocol ProfilePresenterProtocol {
    var router: ProfileRouterProtocol? { get set}
    var profileView: ProfileViewProtocol? { get set }
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    var router: ProfileRouterProtocol?
    
    var profileView: ProfileViewProtocol?
    
}
