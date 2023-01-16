//
//  PokemonDetailModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import Foundation

struct PokemonDetailModel {
    let id: Int
    let name: String
    let image: URL?
    let types: [Types]
    let abilities: [Abilities]
    let baseExperience: Int
    let height: Int
    let order: Int
    let weight: Int
}

struct PokemonDetailTableItem {
    let title: String
    let content: String
}
