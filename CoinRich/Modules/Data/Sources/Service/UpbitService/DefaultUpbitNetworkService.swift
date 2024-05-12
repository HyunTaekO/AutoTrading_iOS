//
//  DefaultNetworkService.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Alamofire
import SwiftJWT
import RxSwift

final class DefaultUpbitNetworkService: UpbitNetworkService {
    
    var accessKey: String
    var secretKey: String
    
    init(accessKey: String, 
         secretKey: String)
    {
        self.accessKey = accessKey
        self.secretKey = secretKey
    }
    
    
    func get(_ api: UpbitAPI, query parameter: [String : String]? = nil) -> Single<AFDataResponse<Data>> {
        return Single.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            var components = URLComponents()
            components.queryItems = parameter?.map { URLQueryItem(name: $0, value: $1)}
            let queryHashAlg = components.query?.digest(using: .sha512) ?? ""
            var jwt: JWT<UpbitPayload>?
            if self.accessKey != "" {
                jwt = JWT(claims: UpbitPayload(access_key: self.accessKey,
                                          nonce: UUID().uuidString,
                                          query_hash: queryHashAlg,
                                          query_hash_alg: "SHA512"))
            }
            var headers = HTTPHeaders()
  
            if self.secretKey != "", let secret = self.secretKey.data(using: .utf8),
               var jwt = jwt, let signedJWT = try? jwt.sign(using: .hs256(key: secret)) {
                let authenticationToken = "Bearer " + signedJWT
                headers.add(name: "Authorization", value: authenticationToken)
            }
            
            AF.request(api.baseURL + api.path, parameters: parameter, headers: headers)
                .responseData { response in
                    if let error = response.error {
                        single(.failure(error))
                    }else {
                        Logger.print(try? UpbitAccounts(data: response.data!))
                        single(.success(response))
                    }
                }
            return Disposables.create()
        }
    }
    
    func get(_ api: UpbitAPI, query parameter: [String : String], arrayQuery arrayParameter: [String : [String]]) -> Single<Alamofire.AFDataResponse<Data>> {
        return Single.create{ a in
            return Disposables.create()
        }
    }
    
    func post(_ api: UpbitAPI, body parameter: [String : String]) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
        return Single.create{ a in
            return Disposables.create()
        }
    }
    
    func delete(_ api: UpbitAPI, query parameter: [String : String]?) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
        return Single.create{ a in
            return Disposables.create()
        }
    }
    
}

public enum Logger {
    static func print(_ items: Any) {
            #if DEBUG
            Swift.print("🟢🟢")
            Swift.print("🟢🟢", items)
            Swift.print("🟢🟢")
            #endif
        }
}
