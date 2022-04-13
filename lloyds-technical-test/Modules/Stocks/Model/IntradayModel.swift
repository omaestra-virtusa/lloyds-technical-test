//
//  IntradayModel.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

struct IntradayModel: Decodable {
    var date: String
    var ticker: String
    var data: IntradayDataModel
}

struct IntradayDataModel: Decodable {
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Double
    var isExtendedHours: Bool
    
    enum CodingKeys: String, CodingKey {
        case open, high, low, close, volume
        case isExtendedHours = "is_extended_hours"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        open = try container.decode(Double.self, forKey: .open)
        high = try container.decode(Double.self, forKey: .high)
        low = try container.decode(Double.self, forKey: .low)
        close = try container.decode(Double.self, forKey: .close)
        volume = try container.decode(Double.self, forKey: .volume)
        isExtendedHours = try container.decode(Bool.self, forKey: .isExtendedHours)
    }
}
