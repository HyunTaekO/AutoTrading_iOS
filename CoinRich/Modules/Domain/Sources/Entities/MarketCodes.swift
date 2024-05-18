//
//  MarketCodes.swift
//  DomainManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation

public enum MarketCode: String, CaseIterable {
    case KRW, BTC, XRP
    
    
    public var code: String {
        return "KRW-" + self.rawValue
    }
    public var englishName: String {
        return self.rawValue
    }

}

public typealias MarketCodes = [MarketCode]
