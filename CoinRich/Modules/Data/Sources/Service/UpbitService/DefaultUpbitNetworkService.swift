//
//  DefaultNetworkService.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Alamofire
import SwiftJWT
import RxSwift
import Utils
import Domain

final class DefaultUpbitNetworkService: UpbitNetworkService {
    
    func upbitRequest(_ endPoint: UpbitEndPoint,_ parameters: RequestParameters = nil) -> Single<AFDataResponse<Data>> {
        return Single.create { single in
            guard let request = try? endPoint.asURLRequest(parameters)
            else { return Disposables.create() }
            AF.request(request)
                .responseData { response in
                    if let error = response.error {
                        single(.failure(error))
                    }else {
                        // debug Log
                        try? response.data?.printJsonString()
                        Logger.print(try? response.data?.toObject(UpbitCandles.self))
                        Logger.print(request.url)
                        single(.success(response))
                    }
                }
            return Disposables.create()
        }
    }
    
}


