//
//  UpbitAPI.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation

public enum UpbitAPI {
    case exchange(ExchangeAPI) //quotation(QuotationAPI)
}

extension UpbitAPI {
    var baseURL: String {
        return "https://api.upbit.com/v1"
    }
    
    var path: String {
        switch self {
        case .exchange(let api): return api.path
        //case .quotation(let api): return api.path
        }
    }
}
