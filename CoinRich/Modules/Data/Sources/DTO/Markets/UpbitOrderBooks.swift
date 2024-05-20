//
//  UpbitOrderBooks.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

// MARK: - UpbitOrderBooks 실시간 호가

struct UpbitOrderBook: Codable {
    let ty, cd: String
    let tas, tbs, lv: Double
    let ttms, tms: Int?
    let obu: [UpbitOBU]
}

// MARK: 호가
struct UpbitOBU: Codable {
    //let askPrice, bidPrice, askSize, bidSize: Double
    let obuAp, obuBp, obuAs, obuBs: Double
    enum CodingKeys: String, CodingKey {
        case obuAp = "ap"
        case obuBp = "bp"
        case obuAs = "as"
        case obuBs = "bs"
    }
}
