//
//  DataLayerTests.swift
//  DataManifests
//
//  Created by 오현택 on 5/12/24.
//

import XCTest
import RxSwift
import RxBlocking
import Utils
@testable import Data

// MARK: API 데이터 입출력 테스트
final class HTTPNetworkServiceTests: XCTestCase {
    
    private var networkService: DefaultNetworkService!
    private var disposeBag: DisposeBag!
    private var trainData: TrainData!
    
    override func setUpWithError() throws {
        self.networkService = DefaultNetworkService()
        self.disposeBag = DisposeBag()
        self.trainData = TrainData(symbol: .DOGE, timeType: .minute(.thirty))
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    // MARK: TrainData
    func test_TrainData() {
        let year = 2021
        let month = 02
        let targetStartDate = "\(year)-\(month)-28 15:00:00"
        let targetEndDate = "\(year)-\(month)-01 00:00:00"
        let calendar = Calendar.current
        var startDate = Date.stringToDate(dateString: targetStartDate, type: .toCandleFormat)!
        var endDate = Date.stringToDate(dateString: targetEndDate, type: .toCandleFormat)!
        trainData.addTrainData(startDate, endDate)
        
        let test = try? trainData
            .writeFileSuccess
            .toBlocking(timeout: 3)
            .last()

    }
    
    // MARK: Accounts
    func test_getAccounts() {
        let getAccounts = try? networkService
            .httpRequest(
                UpbitEndpoint.exchange(.asset(.allAccounts))
            )
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(getAccounts, true)
    }
    // MARK: Deposits / Withdraws
    func test_getDeposits_getWithdraws() {
        let getDeposits = try? networkService
            .httpRequest(
                UpbitEndpoint
                    .exchange(
                        .depositAndwithdraw(
                            .depositList(.despositAndWithdrawParam(.KRW))
                        )
                    )
            )
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        let getWithdraws = try? networkService
            .httpRequest(
                UpbitEndpoint
                    .exchange(
                        .depositAndwithdraw(
                            .withdrawList(.despositAndWithdrawParam(.KRW, "asc"))
                        )
                    )
            )
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(getDeposits, true)
        XCTAssertEqual(getWithdraws, true)
    }
    
    // MARK: Markets
    func test_getMarkets() {
        let get = try? networkService
            .httpRequest(UpbitEndpoint.quotation(.marketAll))
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(get, true)
    }
//    
//    // MARK: Candles
    func test_Candles() {
        let get = try? networkService
            .httpRequest(
                UpbitEndpoint
                    .quotation(
                        .candles(.minute(.thirty),
                                 .candleParam(.DOGE, Date.stringToDate(dateString: "2021-02-25 00:00:00", type: .toCandleFormat), 200)
                        )
                    )
            )
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(get, true)
    }

    
    // MARK: Orders
    func test_Orders() {
        let get = try? networkService
            .httpRequest(
                UpbitEndpoint
                    .exchange(
                        .order(
                            .order(
                                .orderParam(
                                    .XRP,
                                    .buy,
                                    2,
                                    710,
                                    .limit
                                )
                            )
                        )
                    )
            )
            .toBlocking(timeout: 0.2).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(get, true)
    }
    
}
