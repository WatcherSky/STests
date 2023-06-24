//
//  CountriesListCoordinator.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import UIKit


protocol CountriesListFlow: AnyObject {
    func coordinateToCountry(cca2Code: String)
}

class CountriesListCoordinator: Coordinator, CountriesListFlow {
    var factory: FactoryViewControllers
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, factory: FactoryViewControllers) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let countriesListViewController = factory.createCountriesListVC()
        countriesListViewController.coordinator = self
        navigationController.pushViewController(countriesListViewController, animated: true)
    }
    
    
    // MARK: - Flow Methods
    func coordinateToCountry(cca2Code: String) {
        let countryCoordinator = CountryDetailCoordinator(cca2Code: cca2Code, factory: FactoryViewControllers(), navigationController: navigationController)
        coordinate(to: countryCoordinator)
    }
}
