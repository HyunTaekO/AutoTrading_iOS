//
//  DataLayerTests.swift
//  DataManifests
//
//  Created by 오현택 on 5/12/24.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Data

final class DataLayerTests: XCTestCase {

    private var networkService: UpbitNetworkService!
    private var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        
        self.networkService = DefaultUpbitNetworkService(accessKey: UpbitKeys.access.key,
                                                         secretKey: UpbitKeys.secret.key
        )
        self.disposeBag = DisposeBag()
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        networkService = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_upbitNetworkService_get() {
        let result = try? networkService
            .get(.exchange(.asset(.allAccounts)), query: ["currency": "KRW"])
            .toBlocking(timeout: 5).first()?
            .error == nil ? true : false
        
        XCTAssertEqual(result, true)
    }

}
