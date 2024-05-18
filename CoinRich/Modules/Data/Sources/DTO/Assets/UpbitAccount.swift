//
//  UpbitAccount.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Domain

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
    
    public func toModel() -> Asset {
        return Asset(currency: self.currency,
                     balance: Double(self.balance) ?? -1,
                     locked: Double(self.locked) ?? -1,
                     avgBuyPrice: Int(avgBuyPrice) ?? -1,
                     unitCurrency: self.unitCurrency)
    }
}

public typealias UpbitAccounts = [UpbitAccount]

extension UpbitAccounts {
    public func toModel() -> Assets {
        return self.map{ $0.toModel() }
    }
    
}
