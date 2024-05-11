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
    func get(_ api: UpbitAPI,
             query parameter: [String: String]?
    ) -> Single<AFDataResponse<Data>>
    
    func get(_ api: UpbitAPI,
             query parameter: [String: String],
             arrayQuery arrayParameter: [String: [String]]
    ) -> Single<AFDataResponse<Data>>
    
    func post(_ api: UpbitAPI,
              body parameter: [String: String]
    ) -> Single<AFDataResponse<Data>>
    
    func delete(_ api: UpbitAPI,
                query parameter: [String: String]?
    ) -> Single<AFDataResponse<Data>>
    
}
