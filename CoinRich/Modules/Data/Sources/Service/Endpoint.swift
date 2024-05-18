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
// MARK: - Parameters
public typealias HTTPRequestParameter = [String: String]

// MARK: Endpoint
protocol Endpoint {
    var upbitAccessKey: String { get }
    var upbitSecretKey: String { get }
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    //var parameter: RequestParameter? { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding? { get }
    func asURLRequest(_ parameter: HTTPRequestParameter?) throws -> URLRequest
    
    //func createWebSocket() -> WebSocket
    
    // for UpbitAPI
    var personal: Bool { get }
    
}

extension Endpoint {
    var upbitAccessKey: String { UpbitKeys.access.key }
    var upbitSecretKey: String { UpbitKeys.secret.key }
    
    var headers: HTTPHeaders { return HTTPHeaders() }
    
    func asURLRequest(_ parameter: HTTPRequestParameter? = nil) throws -> URLRequest {
        let url = URL(string: baseURL + path)
        var request = URLRequest(url: url!)
     
        request.method = method
        
        if personal {
            let queryHash = convertQueryHash(parameter)
            let jwt = request.createJWT(queryHash, upbitAccessKey, upbitSecretKey)
            request.headers = request.headersAppendJWT(jwt)
        }else {
            request.headers = headers
        }
        
        if let encoding = encoding {
            return try encoding.encode(request, with: parameter)
        }
        
        return request
    }
    
}

// for Upbit Authorization - jwt, payload
extension Endpoint {
    
    func convertQueryHash(_ parameters: HTTPRequestParameter?) -> String {
        var components = URLComponents()
        components.queryItems = parameters?.map { URLQueryItem(name: $0, value: $1)}
        
        let queryHashAlg = components.query?.digest(using: .sha512) ?? ""
        return queryHashAlg
    }
    
}

extension URLRequest {
    func headersAppendJWT(_ jwt: String?) -> HTTPHeaders {
        Logger.print(jwt)
        guard let jwtToken = jwt
        else { return HTTPHeaders() }
        var headers = HTTPHeaders()
        
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
