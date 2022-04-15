//
//  MockedNavigationController.swift
//  lloyds-technical-testTests
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation
import UIKit

class MockedNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
