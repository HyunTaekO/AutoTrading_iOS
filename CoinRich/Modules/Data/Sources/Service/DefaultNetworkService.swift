//
//  DefaultNetworkService.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Alamofire
import SwiftJWT
import RxSwift
import RxRelay
import Utils
import Domain
import Starscream

final class DefaultNetworkService: NetworkService {
    
    var upbitPersonalWS: WebSocketService?
    var upbitOpenWS: WebSocketService?
    let wsCompression: WSCompression = WSCompression()
    
    // MARK: HTTP Request
    func httpRequest(_ endPoint: Endpoint) -> Single<AFDataResponse<Data>> {
        return Single.create { single in
            
            guard let request = try? endPoint.asURLRequest()
            else { return Disposables.create() }
            Logger.print(try? request.httpBody?.toString(), "httpBody")
            //Logger.print(try? request.headers, "headers")
            AF.request(request)
                .responseData { response in
                    if let error = response.error {
                        //Logger.print(request.url ?? "nil", "실패 URL")
                        single(.failure(error))
                    }else {
                        // debug Log
                        try? response.data?.printJsonString()
                        Logger.print(try? response.data?.toObject(UpbitOrder.self))
                        Logger.print(request.url ?? "nil", "성공 URL")
                        single(.success(response))
                    }
                }
            return Disposables.create()
        }
    }
    
}

// MARK: WebSocket Methods
extension DefaultNetworkService {
    func connectWebSockets(_ wsType: WebSockets) {
        switch wsType {
        case .upbit(let type):
            switch type {
            case .open(_):
                self.upbitOpenWS = WebSocketService(ws: type.createWebSocket(wsCompression))
                self.upbitOpenWS?.wsConnect()
            case .personal(_):
                self.upbitPersonalWS = WebSocketService(ws: type.createWebSocket(wsCompression))
                self.upbitPersonalWS?.wsConnect()
            }
        }
        
    }
    
    func requestUpbitWS(_ wsType: WebSockets,_ message: UpbitWSMessage) {
        switch wsType {
        case .upbit(let type):
            switch type {
            case .open(_):
                self.upbitOpenWS?.wsRequest(from: message.messageToString())
            case .personal(_):
                self.upbitPersonalWS?.wsRequest(from: message.messageToString())
            }
        }
    }

    
    func disconnectWebSockets(_ wsType: WebSockets) {
        switch wsType {
        case .upbit(let type):
            switch type {
            case .open(_):
                self.upbitOpenWS?.wsDisconnect()
            case .personal(_):
                self.upbitPersonalWS?.wsDisconnect()
            }
        }
    }
    
}
