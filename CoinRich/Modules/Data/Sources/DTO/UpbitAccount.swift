//
//  UpbitAccount.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation

public struct UpbitAccount: Codable {
    public let currency: String
    public let balance: String
    public let locked: String
    public let avgBuyPrice: String
    public let avgBuyPriceModified: Bool
    public let unitCurrency: String
    
    enum CodingKeys: String, CodingKey {
        case currency, balance, locked
        case avgBuyPrice = "avg_buy_price"
        case avgBuyPriceModified = "avg_buy_price_modified"
        case unitCurrency = "unit_currency"
    }
}

public typealias UpbitAccounts = [UpbitAccount]
