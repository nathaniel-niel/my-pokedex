//
//  FavoritePokemonRealmModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var pokemonId: Int
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var types: String
    @Persisted var abilities: String
    @Persisted var base_experience: String
    @Persisted var height: String
    @Persisted var weight: String
    
    convenience init(pokemonId: Int, name: String, image: String, types: String, abilities: String, base_experience: String, height: String, weight: String) {
        self.init()
        self.pokemonId = pokemonId
        self.name = name
        self.image = image
        self.types = types
        self.abilities = abilities
        self.base_experience = base_experience
        self.height = height
        self.weight = weight
    }
}
