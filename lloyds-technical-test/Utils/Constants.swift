//
//  Constants.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 15/04/2022.
//

import Foundation

enum Constants {
    enum DateInterval: String, CustomStringConvertible {
        case day, week, month, quarter, year
        
        var description: String {
            switch self {
            case .day: return "1D"
            case .week: return "1W"
            case .month: return "1M"
            case .quarter: return "1Q"
            case .year: return "1Y"
            }
        }
    }
    
    static var dateIntervals: [DateInterval] {
        return [.day, .week, .month, .quarter, .year]
    }
    
    static var initialSymbols: [String] {
        return ["AAPL", "TSLA", "MSFT"]
    }
}
