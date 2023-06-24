//
//  AppCoordinator.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let countriesListCoordinator = CountriesListCoordinator(navigationController: navigationController, factory: FactoryViewControllers())
        coordinate(to: countriesListCoordinator)
    }
}
