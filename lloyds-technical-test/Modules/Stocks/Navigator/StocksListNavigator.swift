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
        case news
    }
    
    internal weak var navigationController: UINavigationController?

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
            let viewController = StocksTableViewController.create(navigator: self)
            
            return viewController
        case .quoteDetails(let quote):
            let service = StocksService(network: AlamofireNetworking())
            let viewController = StockDetailsViewController.create(quote: quote,
                                                                   navigator: self,
                                                                   service: service)
            
            return viewController
            
        case .news:
            let service = NewsService(network: MockNetworking())
            let presenter = NewsListPresenter(service: service)
            let viewController = NewsViewController.create(presenter: presenter)
            
            return viewController
        }
    }
}
