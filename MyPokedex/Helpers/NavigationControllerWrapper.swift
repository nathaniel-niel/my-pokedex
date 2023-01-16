//
//  NavigationControllerWrapper.swift
//  MyPokedex
//
//  Created by Nathaniel Andrian on 14/01/23.
//

import Foundation
import UIKit

func navigationControllerWrapper(viewController: UIViewController) -> UIViewController {
    let navController = UINavigationController(rootViewController: viewController)
//    navController.navigationBar.prefersLargeTitles = true
//    navController.navigationBar.isTranslucent = true
    return navController
}
