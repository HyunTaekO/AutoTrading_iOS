//
//  UpbitWebSockets.swift
//  DataManifests
//
//  Created by 오현택 on 5/16/24.
//

import Foundation
import Domain

public enum UpbitWebSocketRequests {
    case ticker, trade, orderBook, myTrade, myOrder, myAsset
}

extension UpbitWebSocketRequests {
    var request: String {
        switch self {
        default:
            ""
        }
    }
}
