//
//  DataLayerTests.swift
//  DataManifests
//
//  Created by 오현택 on 5/12/24.
//

import XCTest
@testable import Data
import Alamofire
import RxSwift

final class DataLayerTests: XCTestCase {

    private var upbitService: DefaultUpbitService!
    private var disposeBag = DisposeBag()
    override func setUpWithError() throws {
        try super.setUpWithError()
        upbitService = DefaultUpbitService(diposeBag: disposeBag)
    }

    func test_getAccounts_success() {
        // Given
        let expectation = XCTestExpectation(description: "UpbitAPI Access Test")
        let single = upbitService.getAccounts()
        var receivedValue: UpbitAccounts? = nil
       
        // When
        single.subscribe(onSuccess: { value in
            receivedValue = value
            Logger.print(value)
            expectation.fulfill()
        }, onFailure: {error in
            print("error", error)
        })
        .disposed(by: self.disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 3.0) // expectation을 기다려서 timeout 내에 fulfill이 되는지 확인
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
