//
//  UpbitAPI.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Alamofire
import Utils
import SwiftJWT
import Starscream

enum UpbitEndpoint {
    case exchange(ExchangeAPI), quotation(QuotationAPI)
}

// MARK: HTTP REQUEST
extension UpbitEndpoint: Endpoint {
    
    var baseURL: String {
        switch self {
//        case .webSocket:
//            return "wss://api.upbit.com/websocket/v1"
        default:
            return "https://api.upbit.com/v1"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .exchange(let api): return api.path
        case .quotation(let api): return api.path
        }
    }

    var encoding: ParameterEncoding? {
        switch self {
        case .exchange(.depositAndwithdraw(_)),
                .quotation(_):
            return URLEncoding.default
        default:
            return nil
        }
        
    }

    var personal: Bool {
        switch self {
        case .exchange(_):
            return true
        default:
            return false
        }
    }

}

// MARK: WebSockets
extension UpbitEndpoint {
    
    
    

}
