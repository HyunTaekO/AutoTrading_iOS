//
//  UPbitCandle.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

// MARK: - UpbitCandle
struct UpbitCandle: Codable {
    let market, candleDateTimeUTC, candleDateTimeKst: String
    let openingPrice, highPrice, lowPrice, tradePrice: Double
    let timestamp: Int
    let candleAccTradePrice, candleAccTradeVolume: Double
    let unit, changePrice: Int?
    let changeRate: Double?
    
    enum CodingKeys: String, CodingKey {
        case market, timestamp, unit
        case candleDateTimeUTC = "candle_date_time_utc"
        case candleDateTimeKst = "candle_date_time_kst"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case candleAccTradePrice = "candle_acc_trade_price"
        case candleAccTradeVolume = "candle_acc_trade_volume"
        case changePrice = "change_price"
        case changeRate = "change_rate"
    }
}

typealias UpbitCandles = [UpbitCandle]
