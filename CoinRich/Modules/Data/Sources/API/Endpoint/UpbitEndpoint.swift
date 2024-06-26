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
            return "https://api.upbit.com/v1"
    }
    
    public var method: HTTPMethod {
        switch self {
        case .exchange(.order):
            return .post
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
    
    var parameters: HTTPRequestParameter? {
        switch self {
        case .exchange(let api):
            return api.parameters
        case .quotation(let api):
            return api.parameters
        }
    }

    var encoding: ParameterEncoding? {
        switch self {
        case .exchange(.depositAndwithdraw),
                .quotation:
            return URLEncoding.default
        case .exchange(.order):
            return JSONEncoding.default
        default:
            return nil
        }
        
    }

    var personal: Bool {
        switch self {
        case .exchange:
            return true
        default:
            return false
        }
    }

}
