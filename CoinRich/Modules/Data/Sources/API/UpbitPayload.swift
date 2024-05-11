//
//  Payload.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import SwiftJWT

public struct UpbitPayload: Claims {
    let access_key: String
    let nonce: String
    let query_hash: String
    let query_hash_alg: String
}
