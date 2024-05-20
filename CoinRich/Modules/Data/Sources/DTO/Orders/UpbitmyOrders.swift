//
//  UpbitmyOrders.swift
//  DataManifests
//
//  Created by 오현택 on 5/19/24.
//

import Foundation
// MARK: - UpbitmyOrder 실시간 내 주문

struct UpbitMyOrder: Codable {
    let ty, cd, uid, ab, ot, s, tif, st: String
    let p, ap, v, rv, ev, rsf, rmf, pf, l, ef: Double
    let tc, otms, tms: Int?
}
