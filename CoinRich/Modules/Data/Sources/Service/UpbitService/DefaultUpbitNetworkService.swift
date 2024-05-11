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
    
    let accessKey = Bundle.main.upbitAccessKey ?? ""
    let secretKey = Bundle.main.upbitSecretKey ?? ""
    
    func get(_ api: UpbitAPI, query parameter: [String : String]?) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
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
                    single(.success(response))
                }
            return Disposables.create()
        }
    }
    
    func get(_ api: UpbitAPI, query parameter: [String : String], arrayQuery arrayParameter: [String : [String]]) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
        <#code#>
    }
    
    func post(_ api: UpbitAPI, body parameter: [String : String]) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
        <#code#>
    }
    
    func delete(_ api: UpbitAPI, query parameter: [String : String]?) -> RxSwift.Single<Alamofire.AFDataResponse<Data>> {
        <#code#>
    }
    
}
