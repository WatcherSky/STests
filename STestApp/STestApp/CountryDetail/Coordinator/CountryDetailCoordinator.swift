//
//  CountryDetailCoordinator.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation
import UIKit

protocol CountryDetailFlow: AnyObject {
    
}

class CountryDetailCoordinator: Coordinator, CountryDetailFlow {
    var factory: FactoryViewControllers
    
    weak var navigationController: UINavigationController?
    var cca2Code: String
    
    init(cca2Code: String, factory: FactoryViewControllers, navigationController: UINavigationController) {
        self.cca2Code = cca2Code
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func start() {
        
        let countryViewController = factory.createCountryDetailVC(cca2Code: cca2Code)
        countryViewController.coordinator = self
        navigationController?.pushViewController(countryViewController, animated: true)
    }
}
