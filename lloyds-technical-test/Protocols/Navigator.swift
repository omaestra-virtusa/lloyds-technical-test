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
    associatedtype Children = Navigator
    
    var navigationController: UINavigationController? { get set }
    var children: [Children] { get set }
    
    func navigate(to destination: Destination, navigationType: NavigationType)
}

extension Navigator {
    func navigate(to destination: Destination, navigationType: NavigationType = .push) {
        navigate(to: destination, navigationType: navigationType)
    }
}

enum NavigationType {
    case push
    case overlay
}
