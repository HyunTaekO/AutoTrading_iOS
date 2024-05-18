//
//  AccountsRepository.swift
//  Manifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
import RxSwift
import Alamofire

public protocol AccountsRepository {
    
    // MARK: ExchangeAPI - Asset
    
    // 현재 보유 종목 조회
    //func getAssets() -> Observable<Assets>
    
    // 입금 내역 조회
    //func getDeposit() -> Observable<>
    // 출금 내역 조회
    
    //func getTotalAssets() -> Observable<TotalAssets>
    // MARK: ExchangeAPI - Exchange
   // func getOrdersChance(market ticker: String) -> Observable<UpbitOrdersChance?>
}
