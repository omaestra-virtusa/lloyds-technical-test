//
//  StocksListNavigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import UIKit

class StocksListNavigator: Navigator {
    typealias Children = NewsNavigator
    
    enum Destination {
        case quotesList
        case quoteDetails(quote: Quote)
        case news
    }
    
    var children: [NewsNavigator]
    var navigationController: UINavigationController?

    var rootViewController: UIViewController? {
        return navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        children = [NewsNavigator(navigationController: navigationController)]
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
    
    func navigateToNews() {
        if let childNavigator = children.last {
            childNavigator.navigate(to: .newsList, navigationType: .overlay)
        }
    }
    
    // MARK: - Private
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .quotesList:
            let viewController = StocksTableViewController.create()
            
            let service = StocksService(network: AlamofireNetworking())
            let presenter = StocksListPresenter(service: service)
            presenter.view = viewController
            
            viewController.navigator = self
            viewController.presenter = presenter
            
            return viewController
        case .quoteDetails(let quote):
            let service = StocksService(network: AlamofireNetworking())
            let viewController = StockDetailsViewController.create(quote: quote,
                                                                   service: service)
            viewController.navigator = self
            
            return viewController
        default:
            return UIViewController()
        }
    }
}
