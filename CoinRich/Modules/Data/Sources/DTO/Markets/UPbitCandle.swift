//
//  UPbitCandle.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

// MARK: - UpbitCandle
public struct UpbitCandle: Codable {
    public let market, candleDateTimeUTC, candleDateTimeKst: String
    public let openingPrice, highPrice, lowPrice, tradePrice: Double
    public let timestamp: Int
    public let candleAccTradePrice, candleAccTradeVolume: Double
    public let unit, changePrice: Int?
    public let changeRate: Double?

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

public typealias UpbitCandles = [UpbitCandle]
