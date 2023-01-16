//
//  ViewSource.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 14/01/23.
//

import Foundation
import UIKit


struct TabBarMenu {
    let viewController: UIViewController
    let title: String
    let icon: UIImage
}

let pokedexViewModel = PokedexViewModel()

let tabBarMenu: [TabBarMenu] = {
    let pokedexViewController = PokedexViewController()
    let favoritePokemonViewController = FavoritePokemonViewController()
    return [
        .init(viewController: navigationControllerWrapper(viewController: pokedexViewController), title: "Pokedex", icon: UIImage(systemName: "magnifyingglass.circle.fill")!),
        .init(viewController: navigationControllerWrapper(viewController: favoritePokemonViewController), title: "Favorite", icon: UIImage(systemName: "star.circle.fill")!)
    ]
}()
