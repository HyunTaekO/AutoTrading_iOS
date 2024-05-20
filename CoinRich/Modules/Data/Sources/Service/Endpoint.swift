//
//  EndPoint.swift
//  DataManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation
import Alamofire
import Starscream
import SwiftJWT
import Utils

enum Markets {
    case upbit
}

typealias HTTPRequestParameter = [String: String]

// MARK: Endpoint
protocol Endpoint {
    var upbitAccessKey: String { get }
    var upbitSecretKey: String { get }
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: HTTPRequestParameter? { get }
    var encoding: ParameterEncoding? { get }
    func asURLRequest() throws -> URLRequest
        
    // for UpbitAPI
    var personal: Bool { get }
    
}

extension Endpoint {
    var upbitAccessKey: String { UpbitKeys.access.key }
    var upbitSecretKey: String { UpbitKeys.secret.key }
    
    var headers: HTTPHeaders { return HTTPHeaders() }
    
    func asURLRequest() throws -> URLRequest {
        let queryString = toQueryString(parameters)
        let url = URL(string: baseURL + path)
        var request = URLRequest(url: url!)
        
        request.method = method
        request.headers = headers
        
        if personal {
            
            let queryHash = convertQueryHash(queryString)
            let jwt = request.createJWT(queryHash, upbitAccessKey, upbitSecretKey)
            request.headers = request.headersAppendJWT(jwt)
        }
        
        if let encoding = encoding {
            return try encoding.encode(request, with: parameters)
        }
        
        return request
    }
    
}

// for Upbit Authorization - jwt, payload
extension Endpoint {
    
    func toQueryString(_ parameters: HTTPRequestParameter?) -> String? {
        let queryString = parameters?.map { "\($0)=\($1)" }.joined(separator: "&")
        return queryString
    }
    
    func convertQueryHash(_ queryString: String?) -> String {
        guard let queryString = queryString else{ return "" }
        let queryHashAlg = queryString.digest(using: .sha512)
        return queryHashAlg
    }
    
}

extension URLRequest {
    func headersAppendJWT(_ jwt: String?) -> HTTPHeaders {
        guard let jwtToken = jwt
        else { return HTTPHeaders() }
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "Authorization", value: jwtToken)
        return headers
    }
    
    func createJWT(_ queryHash: String? = nil,_ accessKey: String,_ secretKey: String) -> String? {
        var jwt: JWT<UpbitPayload>?
        if let queryHash = queryHash {
            jwt = JWT(claims: UpbitPayload(access_key: accessKey,
                                           nonce: UUID().uuidString,
                                           query_hash: queryHash,
                                           query_hash_alg: "SHA512")
            )
        }else {
            jwt = JWT(claims: UpbitPayload(access_key: accessKey,
                                           nonce: UUID().uuidString)
            )
        }
        
        
        if let secret = secretKey.data(using: .utf8),
           var jwt = jwt,
           let signedJWT = try? jwt.sign(using: .hs256(key: secret))
        {
           return "Bearer " + signedJWT
        }
        
        return nil
    }
    
}
