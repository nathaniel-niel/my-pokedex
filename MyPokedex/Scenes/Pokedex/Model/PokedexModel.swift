//
//  PokedexModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation

struct PokedexPaginationRemoteModel: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: URL
}

struct PokemonDetailRemote: Decodable {
    let id: Int
    let name: String
    let base_experience: Int
    let height: Int
    let order: Int
    let weight: Int
    let abilities: [Abilities]
    let sprites: Sprites
    let types: [Types]
}

struct Abilities: Decodable {
    let is_hidden: Bool
    let slot: Int
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
    let url: URL
}

struct Sprites: Decodable {
    let front_default: URL?
}

struct Types: Decodable {
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}
