//
//  PokemonDetailViewModel.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 16/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class PokemonDetailViewModel {
    
    let saveActionComplete = PublishSubject<Void>()
    
    var item = BehaviorRelay<PokemonDetailModel>(value: .init(
        id: 0,
        name: "",
        image: nil,
        types: [],
        abilities: [],
        baseExperience: 0,
        height: 0,
        order: 0,
        weight: 0))
    
    var tableItem = BehaviorRelay<[PokemonDetailTableItem]>(value: [])
    
    var pokemonDetail: PokemonDetailModel
    let tableViewSize = 6
    
    init(pokemonDetail: PokemonDetailModel) {
        self.pokemonDetail = pokemonDetail
        bindData()
        bindItemDetailData()
    }
    
    func bindData() {
        item.accept(pokemonDetail)
    }
    
    func bindItemDetailData() {
        tableItem.accept([
            .init(title: "Types", content: typesMapper(types: pokemonDetail.types)),
            .init(title: "Abilities", content: abilitiesMapper(abilities: pokemonDetail.abilities)),
            .init(title: "Base Experience", content: String(pokemonDetail.baseExperience)),
            .init(title: "Height", content: String(pokemonDetail.height)),
            .init(title: "Weight", content: String(pokemonDetail.weight))
        ])
    }
    
    func saveToFavorite() {
        let data = pokemonDetail
        LocalDBManager.shared.write(.init(
            pokemonId: data.id,
            name: data.name,
            image: data.image?.absoluteString ?? "",
            types: typesMapper(types: pokemonDetail.types),
            abilities: abilitiesMapper(abilities: pokemonDetail.abilities),
            base_experience: String(data.baseExperience),
            height: String(data.height),
            weight: String(data.weight)))
        saveActionComplete.onNext(())
    }
    
    private func typesMapper(types: [Types]) -> String {
        var type = ""
        types.forEach({
            type += $0.type.name + "\n"
        })
        
        return type
    }
    
    private func abilitiesMapper(abilities: [Abilities]) -> String {
        var ability = ""
        abilities.forEach({
            ability += $0.ability.name + "\n"
        })
        
        return ability
    }
    
    
}
