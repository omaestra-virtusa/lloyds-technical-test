//
//  Quote.swift
//  lloyds-technical-test
//
//  Created by Oswaldo Maestra on 13/04/2022.
//

import Foundation

struct Quote: Decodable {
    var ticker: String
    var name: String
    var exchangeShort: String
    var exchangeLong: String
    var micCode: String
    var currency: String
    var price: Double
    var dayHigh: Double
    var dayLow: Double
    var dayOpen: Double
    var weekHigh: Double
    var weekLow: Double
    var marketCap: Double?
    var previousClosePrice: Double
    var previousClosePriceTime: String
    var dayChange: Double
    var volume: Double
    var isExtendedHoursPrice: Bool
    var lastTradeTime: String
    
    enum CodingKeys: String, CodingKey {
        case ticker, name, currency, price, volume
        case exchangeShort = "exchange_short"
        case exchangeLong = "exchange_long"
        case micCode = "mic_code"
        case dayHigh = "day_high"
        case dayLow = "day_low"
        case dayOpen = "day_open"
        case weekHigh = "52_week_high"
        case weekLow = "52_week_low"
        case marketCap = "market_cap"
        case previousClosePrice = "previous_close_price"
        case previousClosePriceTime = "previous_close_price_time"
        case dayChange = "day_change"
        case isExtendedHoursPrice = "is_extended_hours_price"
        case lastTradeTime = "last_trade_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        ticker = try container.decode(String.self, forKey: .ticker)
        name = try container.decode(String.self, forKey: .name)
        exchangeShort = try container.decode(String.self, forKey: .exchangeShort)
        exchangeLong = try container.decode(String.self, forKey: .exchangeLong)
        micCode = try container.decode(String.self, forKey: .micCode)
        currency = try container.decode(String.self, forKey: .currency)
        price = try container.decode(Double.self, forKey: .price)
        dayHigh = try container.decode(Double.self, forKey: .dayHigh)
        dayLow = try container.decode(Double.self, forKey: .dayLow)
        dayOpen = try container.decode(Double.self, forKey: .dayOpen)
        weekHigh = try container.decode(Double.self, forKey: .weekHigh)
        weekLow = try container.decode(Double.self, forKey: .weekLow)
        marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
        previousClosePrice = try container.decode(Double.self, forKey: .previousClosePrice)
        previousClosePriceTime = try container.decode(String.self, forKey: .previousClosePriceTime)
        dayChange = try container.decode(Double.self, forKey: .dayChange)
        volume = try container.decode(Double.self, forKey: .volume)
        isExtendedHoursPrice = try container.decode(Bool.self, forKey: .isExtendedHoursPrice)
        lastTradeTime = try container.decode(String.self, forKey: .lastTradeTime)
    }
}
