//
//  UPbitTickers.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

// MARK: - UpbitTickers 실시간 시세

struct UpbitTicker: Codable {
    let ty, cd, c, tdt, ttm, ab, h52wdt, l52wdt, ms, mw, st: String
    let op, hp, lp, tp, pcp, cp, scp, cr, scr, tv, atv, atv24h, atp, atp24h, aav, abv, h52wp, l52wp: Double
    let its: Bool
    let dd: Date?
    let ttms, tms: Int
}
