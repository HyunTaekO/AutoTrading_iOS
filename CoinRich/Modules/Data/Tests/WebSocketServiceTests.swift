//
//  WebSocketServiceTests.swift
//  DataManifests
//
//  Created by 오현택 on 5/17/24.
//

import XCTest
import RxSwift
import RxBlocking
import Utils

@testable import Data

final class WebSocketServiceTests: XCTestCase {

    private var networkService: DefaultNetworkService!
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        self.networkService = DefaultNetworkService()
        self.disposeBag = DisposeBag()
        networkService
            .connectWebSockets(.upbit(.open(.ticker)))
        
        let response = try?
            networkService
            .upbitOpenWS?
            .responseConnected
            .toBlocking(timeout: 6)
            .first()

        XCTAssertTrue(response ?? false, "웹소켓 연결이 실패했습니다.")
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
 
    func test_WebSocketRequest() {
        let message = UpbitWSMessage(type: .ticker, codes: [.XRP], isOnlyRealtime: true)
        networkService
            .requestUpbitWS(.upbit(.open(.ticker)), message)
        
        let responseData = try?
            networkService
            .upbitOpenWS?
            .responseData
            .toBlocking(timeout: 10)
            .first()
        XCTAssertNotNil(responseData, "웹소켓 응답이 없습니다.")
    }
    
    func test_WebSocketClose() {
        networkService
            .disconnectWebSockets(.upbit(.open(.ticker)))
        
        let response = try?
            networkService
            .upbitOpenWS?
            .responseData
            .toBlocking(timeout: 20)
            .last()
        Logger.print(response)
        XCTAssertNotNil(response)
    }

}
