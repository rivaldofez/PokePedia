//
//  PokemonDetailViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 07/02/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "charizard")
        
        return imageView
    }()
    
    private let pokemonHeightLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.5m"
        return label
    }()
    
    private let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10 kg"
        return label
    }()
    
    private let pokemonSpeciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seed Pokemon"
        return label
    }()
    
    private let pokemonBaseExpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "64"
        return label
    }()
    
    private let pokemonIDLabel: UILabel = {
        let label = UILabel()
        label.text = "999"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonBriefLabel: UILabel = {
        let label = UILabel()
        label.text = "This is brief explanation about pokemon, so you need to adjust size of this text label"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
