//
//  NetworkService.swift
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import RxSwift
import Alamofire

protocol UpbitNetworkService {
    
    // MARK: HTTP Methods
    func upbitRequest(_ endPoint: UpbitEndPoint,_ parameters: RequestParameters) -> Single<AFDataResponse<Data>>
    
}
