//
//  UpbitHTTPParameters.swift
//  DataManifests
//
//  Created by 오현택 on 5/19/24.
//

import Foundation
import Domain
import Utils

enum UpbitParameters {
    case orderParam(_ market: MarketCode,
               _ side: MarketPosition,
               _ volume: Double,
               _ price: Double,
               _ order_type: OrderType,
               _ identifier: String? = nil,
               _ time_in_force: String? = nil),
         
         despositAndWithdrawParam(_ currency: MarketCode,
                            _ order_by: String? = nil
         ),
         candleParam(_ marketCode: MarketCode,
                     _ to: Date? = nil,
                     _ count: Int)
    
}

// MARK: Parameter Type: [String: String]
extension UpbitParameters {
    var keys: [String] {
        switch self {
        case .orderParam:
            return OrderParams.allCases.map{ $0.rawValue }
        case .despositAndWithdrawParam:
            return DepositAndWithdrawParams.allCases.map{ $0.rawValue }
        case .candleParam:
            return CandleParams.allCases.map{ $0.rawValue }
        }
    }
    
    var values: [String?] {
        switch self {
        case .orderParam(let market, let side, let volume, let price, let orderType, let identifier, let time_in_force):
            return [market.code, side.rawValue, String(volume), String(price), orderType.rawValue, identifier, time_in_force]
        case .despositAndWithdrawParam(let cur, let orderBy):
            return [cur.englishName, orderBy]
        case .candleParam(let market, let to, let count):
            return [market.code, to?.toString(type: .toCandleFormat), String(count)]
        }
    }
    
    var parameter: HTTPRequestParameter {
        let params = Dictionary<String, String>(uniqueKeysWithValues: zip(keys, values).compactMap { key, value in
            guard let value = value else { return nil }
            return (key, value)
        })
        return params
    }
    
    var body: String {
        return "?" + parameter.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}

// MARK: OrderParams
enum OrderParams: String, CaseIterable {
    case market,
         side,
         volume,
         price,
         ord_type,
         identifier,
         time_in_force,
         uuid
}

// MARK: DepositAndWithdrawParams
enum DepositAndWithdrawParams: String, CaseIterable {
    case currency, order_by
}

// MARK: CandleParams
enum CandleParams: String, CaseIterable {
    case market, to, count
}
