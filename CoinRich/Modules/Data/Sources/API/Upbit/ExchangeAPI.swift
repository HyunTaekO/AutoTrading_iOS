//
//  ExchangeAPI.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation

public enum ExchangeAPI {
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
}

public enum AssetAPI {
    case allAccounts
}

extension AssetAPI {
    var path: String {
        switch self {
        case .allAccounts: return "/accounts"
        }
    }
}

public enum OrderAPI {
    case ordersChance, //주문 가능 정보
         searchOrder,
         searchOrders,
         deleteOrder,
         order
}

extension OrderAPI {
    var path: String {
        switch self {
        case .ordersChance: return "/orders/chance"
        case .searchOrder, .deleteOrder: return "/order"
        case .searchOrders, .order: return "/orders"
        }
    }
}

public enum MarketPosition: String {
    case buy = "bid", sell = "ask"
}

public enum depositAndwithdrawAPI {
    case depositList, withdrawList
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
public enum InfoAPI {
    case walletStatus
}

extension InfoAPI {
    var path: String { "/status/wallet" }
}

public enum UpbitMethod {
    case get, delete
}
