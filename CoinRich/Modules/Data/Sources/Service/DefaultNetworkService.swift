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
    
    
    // MARK: HTTP Request
    func httpRequest(_ endPoint: Endpoint,_ parameters: HTTPRequestParameter? = nil) -> Single<AFDataResponse<Data>> {
        return Single.create { single in
            
            guard let request = try? endPoint.asURLRequest(parameters)
            else { return Disposables.create() }
            AF.request(request)
                .validate(statusCode: 200..<400)
                .responseData { response in
                    if let error = response.error {
                        Logger.print(request.url ?? "nil", "URL")
                        Logger.errorPrint(error.errorDescription ?? "")
                        single(.failure(error))
                    }else {
                        // debug Log
                        try? response.data?.printJsonString()
                        Logger.print(try? response.data?.toObject(UpbitAccounts.self))
                        Logger.print(request.url ?? "nil", "URL")
                        single(.success(response))
                    }
                }
            return Disposables.create()
        }
    }
    
}

// MARK: WebSocket Methods
extension DefaultNetworkService {
    func connectWebSockets() {
        WebSocketService.shared.wsConnect(false)

    }
    
    func requestWebSockets(_ message: [WebSocketRequest]) {
        let send: [[String: Any]] = [["ticket": UUID().uuidString]] + message

        if let jsonString = send.toJsonString() {
            WebSocketService.shared.wsRequest(from: jsonString)
        }
        
    }
    
    func disconnectWebSockets() {
        WebSocketService.shared.wsDisconnect()
    }
    
    
}
