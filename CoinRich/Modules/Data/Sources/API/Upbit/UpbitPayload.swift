//
//  Payload.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import SwiftJWT

struct UpbitPayload: Claims {
    let access_key: String
    let nonce: String
    let query_hash: String?
    let query_hash_alg: String?
    
    init(access_key: String, nonce: String, query_hash: String? = nil, query_hash_alg: String? = nil) {
        self.access_key = access_key
        self.nonce = nonce
        self.query_hash = query_hash
        self.query_hash_alg = query_hash_alg
    }

}


