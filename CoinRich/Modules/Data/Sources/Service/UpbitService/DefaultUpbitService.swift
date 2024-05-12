//
//  DefaultUpbitService.swift
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import Alamofire
import SwiftJWT
import RxSwift

public final class DefaultUpbitService: UpbitService {
    
    var networkService: UpbitNetworkService
    let diposeBag: DisposeBag = DisposeBag()
    
    init(networkService: UpbitNetworkService) {
        self.networkService = networkService
    }
    
    public func getAccounts() -> Observable<UpbitAccounts?> {
        return self.networkService.get(.exchange(.asset(.allAccounts)), query: nil)
            .map { response in
                switch response.result {
                case .success(let data):
                    return try? UpbitAccounts(data: data)
                case .failure(let error):
                    Logger.print(error)
                    return nil
                }
            }
            .asObservable()
    }
    
}
