//
//  QuotationAPI.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
import Domain

enum QuotationAPI {
    
    case marketAll, candles(CandleType, UpbitParameters), tradesTicks
}

extension QuotationAPI {
    var path: String {
        switch self {
        case .marketAll: return "/market/all?isDetails=true" // 전체 마켓 코인 정보 조회
        case .candles(let type, _): // 캔들
            switch type { // 시간 타입
            case .minute(let unit):
                return "/candles/minutes/\(unit.rawValue)"
            case .hour(let unit):
                return "/candles/minutes/\(unit.rawValue)"
            case .days:
                return "/candles/days"
            case .weeks:
                return "/candles/weeks"
            case .months:
                return "/candles/months"
            }
        case .tradesTicks: return "/trades/ticks"
        }
    }
    var parameters: HTTPRequestParameter? {
        switch self {
        case .candles(_, let param):
            return param.parameter
        default:
            return nil
        }
    }
}
