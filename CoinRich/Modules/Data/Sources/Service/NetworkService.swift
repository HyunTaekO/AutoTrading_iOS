//
//  NetworkService.swift
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import RxSwift
import Alamofire
import Starscream

enum UpbitNetworkError: Error {
     case badRequest(UpbitHTTPError),
          unauthorized(UpbitHTTPError),
          unowned(UpbitHTTPError?)
}

struct UpbitHTTPError: Decodable {
    let error: UpbitHTTPErrorDetail
    
    struct UpbitHTTPErrorDetail: Decodable {
        let message: String
        let name: String
    }
}

protocol NetworkService {
    // MARK: HTTP
    func httpRequest(_ endPoint: Endpoint) -> Single<AFDataResponse<Data>>
    
    // MARK: WebSocket
    func connectWebSockets(_ wsType: WebSockets)
    func requestUpbitWS(_ wsType: WebSockets,_ message: UpbitWSMessage)
    func disconnectWebSockets(_ wsType: WebSockets)
}
