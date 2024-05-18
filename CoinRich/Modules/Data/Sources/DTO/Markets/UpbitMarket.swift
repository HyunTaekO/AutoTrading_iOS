//
//  UpbitMarket.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

public struct UpbitMarket: Codable {
    public let market: String   // 업비트에서 제공중인 시장 정보
    public let koreanName: String  //  거래 대상 디지털 자산 한글명
    public let englishName: String  // 거래 대상 디지털 자산 영문명
    public let marketWarning: String
    public let marketEvent: MarketEvent?  //  업비트 시장경보 > 유의종목 지정 여부
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
        case marketWarning = "market_warning"
        case marketEvent = "market_event"
    }
}

public typealias UpbitMarkets = [UpbitMarket]

// MARK: - MarketEvent
public struct MarketEvent: Codable {
    let warning: Bool
    let caution: Caution
}

// MARK: - Caution
struct Caution: Codable {
    let priceFluctuations, tradingVolumeSoaring, globalPriceDifferences, concentrationOfSmallAccounts: Bool
    let depositAmountSoaring: Bool

    enum CodingKeys: String, CodingKey {
        case priceFluctuations = "PRICE_FLUCTUATIONS"
        case tradingVolumeSoaring = "TRADING_VOLUME_SOARING"
        case globalPriceDifferences = "GLOBAL_PRICE_DIFFERENCES"
        case concentrationOfSmallAccounts = "CONCENTRATION_OF_SMALL_ACCOUNTS"
        case depositAmountSoaring = "DEPOSIT_AMOUNT_SOARING"
    }
    /*
    - PRICE_FLUCTUATIONS: 가격 급등락 경보 발령 여부
    - TRADING_VOLUME_SOARING: 거래량 급등 경보 발령 여부
    - DEPOSIT_AMOUNT_SOARING: 입금량 급등 경보 발령 여부
    - GLOBAL_PRICE_DIFFERENCES: 가격 차이 경보 발령 여부
    - CONCENTRATION_OF_SMALL_ACCOUNTS: 소수 계정 집중 경보 발령 여부
    */
}
