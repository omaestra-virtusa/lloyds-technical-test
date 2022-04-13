//
//  TabNavigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import UIKit

protocol TabNavigatorProtocol: Navigator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

//class TabNavigator: NSObject, Navigator {
//    weak var finishDelegate: NavigatorFinishDelegate?
//        
//    var childNavigators: Array<Navigator> = []
//
//    var navigationController: UINavigationController
//    
//    var tabBarController: UITabBarController
//
//    var type: NavigationType { .tab }
//    
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = .init()
//    }
//
//    func start() {
//        let pages: [TabBarPage] = [.stocks, .news, .account]
//            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
//        
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//        
//        prepareTabBarController(withTabControllers: controllers)
//    }
//    
//    deinit {
//        print("TabNavigator deinit")
//    }
//    
//    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
//        tabBarController.delegate = self
//        tabBarController.setViewControllers(tabControllers, animated: true)
//        tabBarController.selectedIndex = TabBarPage.stocks.pageOrderNumber()
//        tabBarController.tabBar.isTranslucent = false
//        
//        navigationController.viewControllers = [tabBarController]
//    }
//      
//    private func getTabController(_ page: TabBarPage) -> UINavigationController {
//        let navController = UINavigationController()
//        navController.setNavigationBarHidden(false, animated: false)
//
//        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
//                                                     image: nil,
//                                                     tag: page.pageOrderNumber())
//
//        switch page {
//        case .stocks:
//            // If needed: Each tab bar flow can have it's own Navigator.
//            let readyVC = UIViewController()
//            self.selectPage(.stocks)
//                        
//            navController.pushViewController(readyVC, animated: true)
//        default:
//            break
//        }
//        
//        return navController
//    }
//    
//    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
//
//    func selectPage(_ page: TabBarPage) {
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//    
//    func setSelectedIndex(_ index: Int) {
//        guard let page = TabBarPage.init(index: index) else { return }
//        
//        tabBarController.selectedIndex = page.pageOrderNumber()
//    }
//}
//
//extension TabNavigator: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController,
//                          didSelect viewController: UIViewController) {
//        // Some implementation
//    }
//}
