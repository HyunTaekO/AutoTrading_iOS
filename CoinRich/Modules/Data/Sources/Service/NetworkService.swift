//
//  NetworkService.swift
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import RxSwift
import Alamofire
import Starscream

protocol NetworkService {
    // MARK: HTTP
    func httpRequest(_ endPoint: Endpoint,_ parameters: HTTPRequestParameter?) -> Single<AFDataResponse<Data>>
    
    // MARK: WebSocket
    func connectWebSockets()
    func requestWebSockets(_ message: [WebSocketRequest])
    func disconnectWebSockets()
}
