//
//  ViewController.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 13/01/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let tabBarModel = tabBarMenu

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    private func setupMenu() {
        view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        var menuItem: [UIViewController] = []
        tabBarModel.enumerated().forEach { index, menu in
            menu.viewController.tabBarItem = UITabBarItem(title: menu.title, image: menu.icon, tag: index)
            menuItem.append(menu.viewController)
        }
        viewControllers = menuItem
    }
}

