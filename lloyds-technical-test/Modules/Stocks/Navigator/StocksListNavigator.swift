//
//  StocksListNavigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import UIKit

final class StocksListNavigator: Navigator {
    enum Destination {
        case quotesList
        case quoteDetails(quote: Quote)
    }
    
    private weak var navigationController: UINavigationController?

    var rootViewController: UIViewController? {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    
    func navigate(to destination: Destination, navigationType: NavigationType) {
        let viewController = makeViewController(for: destination)
        
        switch navigationType {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
            
        case .overlay:
            navigationController?.present(viewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .quotesList:
            let viewController = StocksTableViewController.create()
            viewController.navigator = self
            
            return viewController
        case .quoteDetails(let quote):
            return UIViewController()
        }
    }
}
