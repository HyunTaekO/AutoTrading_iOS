//
//  WebSocketServiceTests.swift
//  DataManifests
//
//  Created by 오현택 on 5/17/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest
import Utils

@testable import Data

final class WebSocketServiceTests: XCTestCase {

    private var networkService: DefaultNetworkService!
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    override func setUpWithError() throws {
        self.networkService = DefaultNetworkService()
        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
        networkService
            .connectWebSockets(.upbit(.open(.ticker)))
        
        let openWS = try?
            networkService
            .upbitOpenWS?
            .responseConnected
            .toBlocking(timeout: 5)
            .first()

        XCTAssertTrue(openWS ?? false, " Open 웹소켓 연결이 실패했습니다.")
        
        networkService
            .connectWebSockets(.upbit(.personal(.myAsset)))
        
        let personalWS = try?
            networkService
            .upbitPersonalWS?
            .responseConnected
            .toBlocking(timeout: 5)
            .first()
        Thread.sleep(forTimeInterval: 5)

        XCTAssertTrue(personalWS ?? false, "Personal 웹소켓 연결이 실패했습니다.")
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        disposeBag = nil
        scheduler = nil
        try super.tearDownWithError()
    }
 
    func test_OpenWebSocketRequest() {
        let message = UpbitWSMessage(type: .ticker, codes: [.XRP])
        networkService
            .requestUpbitWS(.upbit(.open(.ticker)), message)
        
        let responseData = try?
            networkService
            .upbitOpenWS?
            .responseTickers
            .toBlocking(timeout: 5)
            .first()
        XCTAssertNotNil(responseData, "Open 웹소켓 응답이 없습니다.")
    }
    
    func test_PersonalWebSocketRequest() {
        let message = UpbitWSMessage(type: .myAsset)
        networkService
            .requestUpbitWS(.upbit(.personal(.myAsset)), message)
        
        do {
            let responseData = try networkService
                .upbitPersonalWS?
                .responseMyOrders
                .toBlocking(timeout: 500)
                .first()
            
            if let responseData = responseData {
                XCTAssertEqual(responseData.ty, "myAsset")
            }else {
                XCTFail("NO Response Data")
            }
            
        }catch {
            XCTFail("Error blocking for response: \(error)")
        }
        
    
    }
}
