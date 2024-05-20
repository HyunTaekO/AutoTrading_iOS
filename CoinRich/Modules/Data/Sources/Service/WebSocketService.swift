//
//  WeSockets.swift
//  DataManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation
import Starscream
import RxSwift
import RxCocoa
import RxRelay
import Utils

// MARK: WebSocketService
final class WebSocketService {
    
    // Responses
    var responseConnected = PublishSubject<Bool>()
    var responseTickers = PublishSubject<UpbitTicker>()
    var responseTrades = PublishSubject<UpbitTrade>()
    var responseOrderBooks = PublishSubject<UpbitOrderBook>()
    var responseMyOrders = PublishSubject<UpbitMyOrder>()
    var responseMyAssets = PublishSubject<String?>()
    var isConnected = BehaviorRelay<Bool>(value: false)
    
    // Socket
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
        Logger.print(message, "Request Message")
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
            Logger.print(code, "disconnected")
        case .text(let text):
            Logger.print(text, "TEXT")
        case .binary(let data):
            try? data.printJsonString()
            //responseMyAssets.onNext(try? data.toString())
            if let ticker = data.toObject(UpbitTicker.self) {
                Logger.print(ticker, "UpbitTicker")
                responseTickers.onNext(ticker)
            }else if let trade = data.toObject(UpbitTrade.self) {
                Logger.print(trade, "UpbitTrade")
                responseTrades.onNext(trade)
            }else if let orderbook = data.toObject(UpbitOrderBook.self) {
                Logger.print(orderbook, "UpbitOrderBook")
                responseOrderBooks.onNext(orderbook)
            }else if let myOrder = data.toObject(UpbitMyOrder.self) {
                Logger.print(myOrder, "UpbitMyOrder")
                responseMyOrders.onNext(myOrder)
            }
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
