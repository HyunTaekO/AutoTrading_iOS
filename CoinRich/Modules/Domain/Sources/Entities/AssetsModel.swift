//
//  AssetsModel.swift
//  DomainManifests
//
//  Created by 오현택 on 5/11/24.
//

import Foundation

public struct Asset {
    public let currency: String // 화폐 종류
    public let balance: Double // 보유 금액/수량
    public let locked: Double // 미체결 주문 금액/수량
    public let avgBuyPrice: Int // 매수 평균 금액
    //public let avgBuyPriceModified: Bool // 매수 평균 금액 수정 여부
    public let unitCurrency: String // 평단가 기준 화폐 ex) 원화마켓 == KRW, BTC마켓 == BTC
    
    public init(currency: String, balance: Double, locked: Double, avgBuyPrice: Int, unitCurrency: String) {
        self.currency = currency
        self.balance = balance
        self.locked = locked
        self.avgBuyPrice = avgBuyPrice
        self.unitCurrency = unitCurrency
    }
}

public typealias Assets = [Asset]

public struct CurrentAssets {
    public let totalBalance: Int // 현재 총 보유자산 금액 (KRW)
    public let currentProfits: Int // 현재 수익금 (KRW)
    public let currentRateOfProfits: Int // 현재 수익률
    public let assets: Assets
    
    public init(totalBalance: Int, currentProfits: Int, currentRateOfProfits: Int, assets: [Asset]) {
        self.totalBalance = totalBalance
        self.currentProfits = currentProfits
        self.currentRateOfProfits = currentRateOfProfits
        self.assets = assets
    }
}

public struct TotalAssets {
    public let totalBalance: Int // 총 보유자산 금액 (KRW)
    public let totalDesposit: Int // 총 원화 입금액
    public let totalWithdraw: Int // 총 원화 출금액
    public let totalProfits: Int // 총 수익금 (KRW)
    public let totalRateOfProfits: Int // 총 수익률
    
    public init(totalBalance: Int, totalDesposit: Int, totalWithdraw: Int, totalProfits: Int, totalRateOfProfits: Int) {
        self.totalBalance = totalBalance
        self.totalDesposit = totalDesposit
        self.totalWithdraw = totalWithdraw
        self.totalProfits = totalProfits
        self.totalRateOfProfits = totalRateOfProfits
    }
}
