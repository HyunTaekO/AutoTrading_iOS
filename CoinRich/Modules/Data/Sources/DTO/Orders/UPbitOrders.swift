//
//  UPbitOrders.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
// MARK: - UpbitOrders

struct UpbitOrder: Codable {
    let uuid, side, ordType, price, state, market, createdAt, volume,
        remainingVolume, reservedFee, remainingFee, paidFee,
        locked, executedVolume, timeInForce: String
    let tradesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case uuid, side, price, state, market, volume,
             locked
        case ordType = "ord_type"
        case createdAt = "created_at"
        case remainingVolume = "remaining_volume"
        case reservedFee = "reserved_fee"
        case remainingFee = "remaining_fee"
        case paidFee = "paid_fee"
        case executedVolume = "executed_volume"
        case timeInForce = "time_in_force"
        case tradesCount = "trades_count"
    }
}

enum MarketPosition: String {
    case buy = "bid", sell = "ask"
}


enum OrderType: String {
    case limit // 지정가 주문
    case price // 시장가 주문(매수)
    case market // 시장가 주문(매도)
    case best // 최유리 주문 (time_in_force 설정 필수)
}
