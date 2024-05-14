//
//  UpbitAPI.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation
import Alamofire
import Utils
import SwiftJWT

public enum UpbitEndPoint {
    var accessKey: String { Bundle.main.upbitAccessKey ?? "" }
    var secretKey: String { Bundle.main.upbitSecretKey ?? "" }
    case exchange(ExchangeAPI), quotation(QuotationAPI)
    
}

extension UpbitEndPoint: EndPoint {
    
    var baseURL: String {
        return "https://api.upbit.com/v1"
    }
    
    public var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .exchange(let api): return api.path
        case .quotation(let api): return api.path
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case .exchange(.depositAndwithdraw(_)), 
                .quotation(_):
            return URLEncoding.default
        default:
            return nil
        }
        
    }
    
    var isSecret: Bool {
        switch self {
        case .exchange(_):
            return true
        case .quotation(_):
            return false
        }
    }
    
    public func asURLRequest(_ parameters: [String : String]?) throws -> URLRequest {
        let url = URL(string: baseURL + path)
        var request = URLRequest(url: url!)
        
        request.method = method
        request.headers = createHeaders(parameters, isSecret)
        
        if let encoding = encoding {
            return try encoding.encode(request, with: parameters)
        }
        
        return request
    }
    
}

// MARK: Headers 생성
extension UpbitEndPoint {
    private func createHeaders(_ parameters: RequestParameters,_ isSecret: Bool) -> HTTPHeaders {
        guard self.accessKey != "", self.secretKey != "" else{ return HTTPHeaders() }
        let queryHash = convertQueryHash(parameters)
        var jwt: JWT<UpbitPayload>? = JWT(claims: UpbitPayload(access_key: self.accessKey,
                                                               nonce: UUID().uuidString,
                                                               query_hash: queryHash,
                                                               query_hash_alg: "SHA512"))
        var headers = HTTPHeaders()
        
        // 개인 인증이 필요한 경우 SecretKey 사용 - 내 계좌 정보 접근
        if isSecret {
            if let secret = self.secretKey.data(using: .utf8),
               let signedJWT = try? jwt?.sign(using: .hs256(key: secret))
            {
                let authenticationToken = "Bearer " + signedJWT
                headers.add(name: "Authorization", value: authenticationToken)
            }
        }
        
        return headers
    }
    private func convertQueryHash(_ parameters: RequestParameters) -> String {
        var components = URLComponents()
        components.queryItems = parameters?.map { URLQueryItem(name: $0, value: $1)}
        let queryHashAlg = components.query?.digest(using: .sha512) ?? ""
        return queryHashAlg
    }
}
