//
//  ExchangeAPI.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Domain

enum ExchangeAPI {
    case asset(AssetAPI), order(OrderAPI), depositAndwithdraw(depositAndwithdrawAPI)
}

extension ExchangeAPI {
    var path: String {
        switch self {
        case .asset(let api): return api.path
        case .order(let api): return api.path
        case .depositAndwithdraw(let api): return api.path
        }
    }
    
    var parameters: HTTPRequestParameter? {
        switch self {
        case .asset(let api): return nil
        case .order(let api):
            switch api {
            case .order(let param):
                return param.parameter
            default:
                return nil
            }
        case .depositAndwithdraw(let api):
            switch api {
            case .depositList(let param):
                return param.parameter
            case .withdrawList(let param):
                return param.parameter
            }
        }
    }
    
}

enum AssetAPI {
    case allAccounts
}

extension AssetAPI {
    var path: String {
        switch self {
        case .allAccounts: return "/accounts"
        }
    }
}

enum OrderAPI {
    case ordersChance, //주문 가능 정보
         searchOrder,
         searchOrders,
         deleteOrder,
         order(UpbitParameters)
}

extension OrderAPI {
    var path: String {
        switch self {
        case .ordersChance: return "/orders/chance"
        case .searchOrder, .deleteOrder: return "/order"
        case .searchOrders: return "/orders"
        case .order(let param):
            return "/orders" + param.body
        }
    }
    

}

enum depositAndwithdrawAPI {
    case depositList(UpbitParameters),
         withdrawList(UpbitParameters)
}

extension depositAndwithdrawAPI {
    var path: String {
        switch self {
        case .depositList: return "/deposits"
        case .withdrawList: return "/withdraws"
        }
    }
}

// MARK: 입출금 현황 및 블록 상태 조회
enum InfoAPI {
    case walletStatus
}

extension InfoAPI {
    var path: String { "/status/wallet" }
}

enum UpbitMethod {
    case get, delete
}
