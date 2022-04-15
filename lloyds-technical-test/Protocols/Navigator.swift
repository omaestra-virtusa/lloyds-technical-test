//
//  Navigator.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation
import UIKit

protocol Navigator {
    associatedtype Destination
    
//    var finishDelegate: NavigatorFinishDelegate? { get set }
    var navigationController: UINavigationController? { get set }
//    var childNavigators: [Navigator] { get set }
//    var type: NavigationType { get }
//    func start()
//    func finish()
//
//    init(_ navigationController: UINavigationController)
    
    func navigate(to destination: Destination, navigationType: NavigationType)
}

extension Navigator {
//    func finish() {
//        childNavigators.removeAll()
//        finishDelegate?.navigatorDidFinish(childNavigator: self)
//    }
    
    func navigate(to destination: Destination, navigationType: NavigationType = .push) {
        navigate(to: destination, navigationType: navigationType)
    }
}

enum NavigationType {
    case push
    case overlay
}

//protocol NavigatorFinishDelegate: AnyObject {
//    func navigatorDidFinish<N: Navigator>(childNavigator: N)
//}
