//
//  PokemonAboutCellModel.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 16/02/23.
//

import Foundation

struct AboutCellModel {
    let name: String
    let item: [ItemCellModel]
}

struct ItemCellModel {
    let title: String
    let value: String
}
