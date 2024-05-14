//
//  EndPoint.swift
//  DataManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation
import Alamofire

// MARK: - Parameter

public typealias RequestParameters = [String: String]?

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    //var parameters: parameters { get }
    var encoding: ParameterEncoding? { get }
    func asURLRequest(_ parameters: [String : String]?) throws -> URLRequest
}

extension EndPoint {
    var headers: HTTPHeaders { return HTTPHeaders() }
}
