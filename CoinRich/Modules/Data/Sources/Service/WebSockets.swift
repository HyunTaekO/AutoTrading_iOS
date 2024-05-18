//
//  WebSockets.swift
//  DataManifests
//
//  Created by 오현택 on 5/19/24.
//

import Foundation
import Starscream
import Domain

// MARK: WebSocketType
protocol WebSocketType {
    var baseURL: String { get }
    func message(_ send: UpbitWSMessage) -> String
    func createWebSocket() -> WebSocket
}

// MARK: WebSockets
enum WebSockets {
    case upbit(UpbitWebSockets)
}
