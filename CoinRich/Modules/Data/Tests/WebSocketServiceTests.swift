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
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        disposeBag = nil
        try super.tearDownWithError()
    }

    func test_WebSocketConnect() {
        networkService
            .connectWebSockets()

        let response = try?
        WebSocketService.shared.response
            .toBlocking(timeout: 5)
            .last()
        Logger.print(response)
        XCTAssertNotNil(response)
    }
    func test_WebSocketRequest() {
        networkService
            .requestWebSockets([
                ["codes": ["KRW-BTC"],
                 "type": "orderbook"
                ]
            ])

        let response = try?
        WebSocketService.shared.response
            .toBlocking(timeout: 20)
            .last()
        
        XCTAssertNotNil(response)
    }
    
    func test_WebSocketClose() {
        networkService
            .disconnectWebSockets()

        let response = try?
        WebSocketService.shared.response
            .toBlocking(timeout: 5)
            .last()
            
        XCTAssertNotNil(response)
    }

}
