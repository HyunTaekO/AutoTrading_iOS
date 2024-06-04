//
//  CandleRepository.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
import RxSwift
import Domain
import Utils

final class CandleRepository {
    
    private var networkService: NetworkService
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(networkService: NetworkService)
    {
        self.networkService = networkService
    }
    
    
    func fetchCandleData(_ coin: MarketCode ,_ date: Date) -> Observable<UpbitCandles> {
        return self.networkService
            .httpRequest(UpbitEndpoint
                .quotation(.candles(.minute(.thirty), .candleParam(coin, date, 200)))
            )
            .map{ ($0.data?.toObject(UpbitCandles.self))! }
            .asObservable()
    }
}
