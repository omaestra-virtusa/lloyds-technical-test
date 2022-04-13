//
//  TabBarPage.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

enum TabBarPage {
    case stocks
    case news
    case account

    init?(index: Int) {
        switch index {
        case 0:
            self = .stocks
        case 1:
            self = .news
        case 2:
            self = .account
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .stocks:
            return "Stocks"
        case .news:
            return "News"
        case .account:
            return "Account"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .stocks:
            return 0
        case .news:
            return 1
        case .account:
            return 2
        }
    }
}
