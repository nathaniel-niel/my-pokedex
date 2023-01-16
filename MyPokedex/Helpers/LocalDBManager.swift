//
//  LocalDBManager.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import Foundation
import RealmSwift

class LocalDBManager {
    
    static let shared = LocalDBManager()
    let realm = try! Realm()
    
    func write(_ data: FavoritePokemonModel) {
        let pokemonData = Favorite(
            pokemonId: data.pokemonId,
            name: data.name,
            image: data.image,
            types: data.types,
            abilities: data.abilities,
            base_experience: data.base_experience,
            height: data.height,
            weight: data.weight)
        
        try! realm.write({
            realm.add(pokemonData)
        })
    }
    
    func read() -> [FavoritePokemonModel] {
        let pokemonData = realm.objects(Favorite.self)
        return pokemonData.map({
            FavoritePokemonModel(
                pokemonId: $0.pokemonId,
                name: $0.name,
                image: $0.image,
                types: $0.types,
                abilities: $0.abilities,
                base_experience: $0.base_experience,
                height: $0.height,
                weight: $0.weight)
        })
    }
    
    
    
    
}
