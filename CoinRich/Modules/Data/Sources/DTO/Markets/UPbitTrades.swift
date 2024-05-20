//
//  UPbitTradeTicks.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
// MARK: - UpbitTrade 실시간 체결

struct UpbitTrade: Codable {
    let ty, cd, c, ttm, ab, st: String
    let tp, tv, pcp, cp: Double
    let ttms, tms, sid: Int
}
