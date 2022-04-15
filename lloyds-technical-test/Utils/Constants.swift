//
//  Constants.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

enum Constants {
    enum DateInterval: String {
        case day, week, month, quarter, year
    }
    
    static var dateIntervals: [DateInterval] {
        return [.day, .week, .month, .quarter, .year]
    }
    
    static var initialSymbols: [String] {
        return ["AAPL", "TSLA", "MSFT"]
    }
}
