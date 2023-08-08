//
//  FavoriteViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 02/08/23.
//

import UIKit


protocol FavoriteViewProtocol {
    var presenter: FavoritePresenterProtocol? { get set }
    
    func updatePokemonFavorite(with pokemons: [Pokemon])
    func updatePokemonFavorite(with error: String)
    func isLoadingData(with state: Bool)
}


class FavoriteViewController: UIViewController, FavoriteViewProtocol {
    var presenter: FavoritePresenterProtocol?
    
    func updatePokemonFavorite(with pokemons: [Pokemon]) {
        print("success \(pokemons)")
    }
    
    func updatePokemonFavorite(with error: String) {
        print("failed \(error)")
    }
    
    func isLoadingData(with state: Bool) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
