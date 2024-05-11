//
//  UpbitAPIServiceTests.swift
//  Manifests
//
//  Created by 오현택 on 5/12/24.
//

import XCTest
@testable import UpbitAPIService
import Alamofire

final class UpbitAPIServiceTests: XCTestCase {

    private var upbitService: DefaultUpbitService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        upbitService = DefaultUpbitService()
    }

    func test_upbitAccess_success() {
        // Given
        let expectation = XCTestExpectation(description: "UpbitAPI Access Test")
        let single = upbitService.get(.exchange(.asset(.allAccounts)),
                                      query: nil
                     )
        var receivedValue: Alamofire.AFDataResponse<Data>? = nil
       
       
            
        // When
        single.subscribe(onSuccess: { value in
            receivedValue = value
            expectation.fulfill()
        })
        .dispose()

        // Then
        wait(for: [expectation], timeout: 2.0) // expectation을 기다려서 timeout 내에 fulfill이 되는지 확인
        XCTAssertEqual("", nil) // 예상한 결과와 일치하는지 확인

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func tearDownWithError() throws {
        upbitService = nil
        try super.tearDownWithError()
    }
}
