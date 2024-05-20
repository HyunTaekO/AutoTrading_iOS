//
//  UpbitAccount.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Domain

// MARK: HTTP 자산 요청
struct UpbitAccount: Codable {
    let currency: String
    let balance: String
    let locked: String
    let avgBuyPrice: String
    let avgBuyPriceModified: Bool
    let unitCurrency: String
    
    enum CodingKeys: String, CodingKey {
        case currency, balance, locked
        case avgBuyPrice = "avg_buy_price"
        case avgBuyPriceModified = "avg_buy_price_modified"
        case unitCurrency = "unit_currency"
    }
    
    func toModel() -> Asset {
        return Asset(currency: self.currency,
                     balance: Double(self.balance) ?? -1,
                     locked: Double(self.locked) ?? -1,
                     avgBuyPrice: Int(avgBuyPrice) ?? -1,
                     unitCurrency: self.unitCurrency)
    }
}

typealias UpbitAccounts = [UpbitAccount]

extension UpbitAccounts {
    public func toModel() -> Assets {
        return self.map{ $0.toModel() }
    }
}

// MARK: WebSocket 실시간 자산 요청
struct UpbitMyAsset: Codable {
    let ty, astuid, st: String
    let asttms, tms: Int
    let ast: [AST]
}

struct AST: Codable {
    let cu: String
    let b, l: Double
}
