//
//  AboutSubViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 10/02/23.
//

import UIKit

class AboutSubViewController: UIViewController {
    
    private var aboutDataModel: [AboutCellModel] = []
    
    var pokemonSpecies: PokemonSpecies? {
        didSet {
            guard let pokemonSpecies = pokemonSpecies else { return }
            let pokemonAbout = {
                return pokemonSpecies.about
                    .replacingOccurrences(of: "\n", with: " ")
                    .utf8EncodedString()
                    .replacingOccurrences(of: "\\014", with: " ")
                    .utf8DecodedString()
            }()
            
            aboutLabel.text = pokemonAbout
            
            setDataAboutTableView()
        }
    }
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            
            heightLabel.text = "\(pokemon.height) m"
            weightLabel.text = "\(pokemon.weight) kg"
        }
    }
    
    private func setDataAboutTableView(){
        guard let pokemon = pokemon, let pokemonSpecies = pokemonSpecies else { return }
        
        var speciesItemCellModel: [ItemCellModel] = []
        speciesItemCellModel.append(ItemCellModel(title: "Genus", value: pokemonSpecies.genus))
        speciesItemCellModel.append(ItemCellModel(title: "Height", value: String(pokemon.height)))
        speciesItemCellModel.append(ItemCellModel(title: "Weight", value: String(pokemon.weight)))
        speciesItemCellModel.append(ItemCellModel(title: "Abilities", value: pokemon.abilities))
        speciesItemCellModel.append(ItemCellModel(title: "Status", value: pokemonSpecies.isLegendary ? "Legendary" : pokemonSpecies.isMythical ? "Mythical" : "Common"))
        speciesItemCellModel.append(ItemCellModel(title: "Habitat", value: pokemonSpecies.habitat))
        let speciesCellModel = AboutCellModel(name: "Species", item: speciesItemCellModel)
        
        var physicalItemCellModel: [ItemCellModel] = []
        physicalItemCellModel.append(ItemCellModel(title: "Growth Rate", value: pokemonSpecies.growthRate))
        physicalItemCellModel.append(ItemCellModel(title: "Hatch Counter", value: String(pokemonSpecies.hatchCounter)))
        physicalItemCellModel.append(ItemCellModel(title: "Base Happines", value: String(pokemonSpecies.baseHappines)))
        physicalItemCellModel.append(ItemCellModel(title: "Base Experience", value: String(pokemon.baseExp)))
        physicalItemCellModel.append(ItemCellModel(title: "Capture Rate", value: String(pokemonSpecies.captureRate)))
        let physicalCellModel = AboutCellModel(name: "Physical", item: physicalItemCellModel)
        
        var breedingItemCellModel: [ItemCellModel] = []
        breedingItemCellModel.append(ItemCellModel(title: "Gender", value: pokemonSpecies.genderRate))
        breedingItemCellModel.append(ItemCellModel(title: "Egg Groups", value: pokemonSpecies.eggGroups))
        breedingItemCellModel.append(ItemCellModel(title: "Baby Breed", value: pokemonSpecies.isBaby ? "Yes" : "No"))
        let breedingCellModel = AboutCellModel(name: "Breeding", item: breedingItemCellModel)
        
        aboutDataModel.append(speciesCellModel)
        aboutDataModel.append(physicalCellModel)
        aboutDataModel.append(breedingCellModel)
        
        DispatchQueue.main.async {
            self.aboutTableView.reloadData()
        }
    }
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .comfortaaLight(size: 16)
        return label
    }()
    
    private let aboutTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(AboutTableViewCell.self, forCellReuseIdentifier: AboutTableViewCell.identifier)
        
        return tableView
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weightLabelStackView: UIStackView = {
        let weightIcon = UIImageView()
        weightIcon.image = UIImage(named: "icon_width")
        weightIcon.frame = CGRect(x: 20, y: 0, width: 0, height: 0)
        weightIcon.contentMode = .scaleAspectFit
        weightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        weightIcon.clipsToBounds = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(weightIcon)
        stackView.addArrangedSubview(self.weightLabel)
        
        let weightLabel = UILabel()
        weightLabel.text = "Weight"
        weightLabel.textAlignment = .center
        
        let weightStackView = UIStackView()
        weightStackView.axis = .vertical
        weightStackView.addArrangedSubview(stackView)
        weightStackView.alignment = .center
        weightStackView.addArrangedSubview(weightLabel)
        
        
        return weightStackView
    }()
    
    private lazy var heightLabelStackView: UIStackView = {
        let heightIcon = UIImageView()
        heightIcon.image = UIImage(named: "icon_height")
        heightIcon.contentMode = .scaleAspectFit
        heightIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        heightIcon.clipsToBounds = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(heightIcon)
        stackView.addArrangedSubview(self.heightLabel)
        
        let heightLabel = UILabel()
        heightLabel.text = "Height"
        heightLabel.textAlignment = .center
        
        let heightStackView = UIStackView()
        heightStackView.axis = .vertical
        heightStackView.addArrangedSubview(stackView)
        //        heightStackView.alignment = .center
        heightStackView.addArrangedSubview(heightLabel)
        
        return heightStackView
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        let uiview = UIView()
        uiview.heightAnchor.constraint(equalToConstant: 25).isActive = true
        uiview.widthAnchor.constraint(equalToConstant: 4).isActive = true
        uiview.backgroundColor = .red
        
        stackView.addArrangedSubview(weightLabelStackView)
        stackView.addArrangedSubview(uiview)
        stackView.addArrangedSubview(heightLabelStackView)
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 16
        stackView.clipsToBounds = true
        stackView.distribution = .equalSpacing
        
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(aboutLabel)
        view.addSubview(aboutTableView)
        configureConstraints()
        
        aboutTableView.delegate = self
        aboutTableView.dataSource = self
    }
    
    private func configureConstraints(){
        let aboutLabelConstraints = [
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let aboutTableViewConstraints = [
            aboutTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutTableView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 15),
            aboutTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ]
        
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(aboutTableViewConstraints)
    }
    
}

extension AboutSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        aboutDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutTableViewCell.identifier, for: indexPath) as? AboutTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: aboutDataModel[indexPath.section].item[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return aboutDataModel[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutDataModel[section].item.count
    }
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
