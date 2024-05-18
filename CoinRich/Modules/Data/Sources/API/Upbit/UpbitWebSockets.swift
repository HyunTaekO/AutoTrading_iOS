//
//  UpbitWebSockets.swift
//  DataManifests
//
//  Created by 오현택 on 5/16/24.
//

import Foundation
import Domain
import Starscream
import Utils

enum UpbitWebSockets: WebSocketType {
    case personal(UpbitWSRequestType), open(UpbitWSRequestType)
}

extension UpbitWebSockets {
    var baseURL: String {
        switch self {
        case .open:
            return "wss://api.upbit.com/websocket/v1"
        case .personal:
            return "wss://api.upbit.com/websocket/v1/private"
        }
    }
    
    func createWebSocket() -> WebSocket {
        var request = URLRequest(url: URL(string: baseURL)!)
        request.timeoutInterval = 5
        switch self {
        case .open:
            break
        case .personal:
            let jwt = request.createJWT(nil, UpbitKeys.access.key, UpbitKeys.secret.key)
            request.headers = request.headersAppendJWT(jwt)
        }
        return WebSocket(request: request)
    }
    
    func message(_ send: UpbitWSMessage) -> String {
        return send.messageToString()
    }
}

enum UpbitWSRequestType: String {
    case ticker,
         trade,
         orderBook = "orderbook",
         myOrder = "myorder",
         myAsset = "myasset"
}


struct UpbitWSMessage {
    let type: UpbitWSRequestType
    let codes: MarketCodes?
    let level: Double?
    let isOnlySnapshot: Bool?
    let isOnlyRealtime: Bool?
    let format: String?
    
    func messageToString() -> String {
        var request: [[String: Any]] = [["ticket": UUID().uuidString]]
        var typeField: [String: Any] = ["type": type.rawValue]
        if let codes = codes {
            typeField.updateValue(codes.map{ $0.code }, forKey: "codes")
        }
        if let level = level {
            typeField.updateValue(level, forKey: "level")
        }
        if let isOnlySnapshot = isOnlySnapshot {
            typeField.updateValue(isOnlySnapshot, forKey: "isOnlySnapshot")
        }
        if let isOnlyRealtime = isOnlyRealtime {
            typeField.updateValue(isOnlyRealtime, forKey: "isOnlyRealtime")
        }
        
        request.append(typeField)
        
        if let format = format {
            request.append(["format": format])
        }
        
        return request.toJsonString() ?? ""
    }
    
    init(type: UpbitWSRequestType,
         codes: MarketCodes? = nil,
         level: Double? = nil,
         isOnlySnapshot: Bool? = nil,
         isOnlyRealtime: Bool? = nil,
         format: String? = nil)
    {
        self.type = type
        self.codes = codes
        self.level = level
        self.isOnlySnapshot = isOnlySnapshot
        self.isOnlyRealtime = isOnlyRealtime
        self.format = format
    }
    
}
