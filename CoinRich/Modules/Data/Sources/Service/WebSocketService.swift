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

// MARK: WebSocketService
final class WebSocketService {
    
    var responseData = PublishSubject<Data>()
    var responseConnected = PublishSubject<Bool>()
    var ws: WebSocket?
    
    init(ws: WebSocket) {
        self.ws = ws
    }
    
    deinit {
        ws?.disconnect()
        ws?.delegate = nil
    }
    
    func wsConnect() {
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
            responseConnected.onNext(true)
                print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            Logger.print(reason, "disconnected")
        case .text(let text):
            Logger.print(text, "TEXT")
        case .binary(let data):
            Logger.print(try? data.printJsonString(), "Data")
            responseData.onNext(data)
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
        
    }
   
}
