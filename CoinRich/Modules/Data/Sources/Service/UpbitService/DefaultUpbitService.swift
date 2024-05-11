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
    
    var diposeBag: DisposeBag
    
    init(diposeBag: DisposeBag) 
    {
        self.diposeBag = diposeBag
    }
    
    let networkService = DefaultUpbitNetworkService()
    
    public func getAccounts() -> Single<UpbitAccounts?> {
        
        return Single.create{ [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            self.networkService.get(.exchange(.asset(.allAccounts)))
                .subscribe(onSuccess: { response in
                    switch response.result {
                    case .success(let data):
                        single(.success(try? UpbitAccounts(data: data)))
                    case .failure(let error):
                        single(.failure(error))
                    }
                })
                .disposed(by: self.diposeBag)
            
            return Disposables.create()
        }
        
    }

}
