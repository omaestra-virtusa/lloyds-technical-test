//
//  NewsNavigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import UIKit

final class NewsNavigator: Navigator {
    enum Destination {
        case newsList
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
        case .newsList:
            let service = NewsService(network: MockNetworking())
            let presenter = NewsListPresenter(service: service)
            let viewController = NewsViewController.create(presenter: presenter)
            
            return viewController
        }
    }
}
