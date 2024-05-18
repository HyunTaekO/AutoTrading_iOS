//
//  WeSockets.swift
//  DataManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation
import Starscream
import RxSwift
import RxRelay
import Utils

// MARK: - WebSocket Request
public typealias WebSocketRequest = [String: Any]

// MARK: WebSocketService
final class WebSocketService {
    static let shared = WebSocketService()
    var response = PublishSubject<WebSocketEvent>()
    var ws: WebSocket?
    
    private init() {}
    
    func wsConnect(_ personal: Bool) {
        
        let url = personal ? "wss://api.upbit.com/websocket/v1/private" : "wss://api.upbit.com/websocket/v1"
        var request = URLRequest(url: URL(string: url)!)
        if personal {
            let jwt = request.createJWT(nil, UpbitKeys.access.key, UpbitKeys.secret.key)
            request.headers = request.headersAppendJWT(jwt)
        }
        request.timeoutInterval = 5
        ws = WebSocket(request: request)
        ws?.delegate = self
        ws?.connect()
    }
    
    func wsRequest(from message: String) {
        Logger.print(message, "wsREQUEST")
        ws?.write(string: message)
    }
    
    func wsDisconnect() {
        ws?.disconnect()
    }
    
}

extension WebSocketService: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let headers):
                print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            Logger.print(reason, "disconnected")
        case .text(let text):
            Logger.print(text, "TEXT")
        case .binary(let data):
            Logger.print(try? data.printJsonString(), "Data")
        case .pong(let pongData):
            Logger.print(pongData, "pongData")
        case .ping(let pingData):
            Logger.print(pingData, "pingData")
        case .error(let error):
            Logger.errorPrint("ERROR", error)
        case .viabilityChanged(let viability):
            Logger.print(viability, "viability")
        case .reconnectSuggested(let reconnect):
            Logger.print(reconnect, "reconnect")
        case .cancelled:
            Logger.print("cancelled")
        case .peerClosed:
            Logger.print("peerClosed")
        }
        response.onNext(event)
    }
   
}
