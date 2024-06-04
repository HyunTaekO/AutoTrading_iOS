//
//  AccountRepository.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
import Alamofire
import SwiftJWT
import RxSwift
import Domain

public final class AccountRepository: AccountsRepository {
    
    var networkService: NetworkService
    var disposeBag: DisposeBag
    
    init(networkService: NetworkService, 
         disposeBag: DisposeBag)
    {
        self.networkService = networkService
        self.disposeBag = disposeBag
    }
    
//    public func getAssets() -> Single<Assets> {
//        let endpoint = UpbitEndpoint.exchange(.asset(.allAccounts))
//        return networkService
//            .httpRequest(endpoint)
//            .map{ $0.data?.compactMap{ $0 } }
//    }
    

}
