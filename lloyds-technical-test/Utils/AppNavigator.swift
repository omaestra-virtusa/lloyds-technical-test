//
//  AppNavigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import UIKit

protocol AppNavigatorProtocol: Navigator {
    func mainFlow()
}

//class AppNavigator: AppNavigatorProtocol {
//    weak var finishDelegate: NavigatorFinishDelegate? = nil
//    
//    var navigationController: UINavigationController
//    
//    var childNavigators = Array<Navigator>()
//    
//    var type: NavigationType { .tab }
//    
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        navigationController.setNavigationBarHidden(true, animated: true)
//    }
//    
//    func start() {
//        mainFlow()
//    }
//    
//    func mainFlow() {
//        let tabNavigator: Navigator = TabNavigator(navigationController)
//        tabNavigator.finishDelegate = self
//        tabNavigator.start()
//        childNavigators.append(tabNavigator)
//    }
//}
//
//extension AppNavigator: NavigatorFinishDelegate {
//    func navigatorDidFinish<N>(childNavigator: N) where N : Navigator {
//        childNavigators = childNavigators.filter({ $0.type != childNavigator.type })
//    }
//}
