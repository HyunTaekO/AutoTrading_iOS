//
//  NetworkService.swift
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import RxSwift

// MARK: API 통신을 위한 프로토콜
protocol NetworkService {
    func request() -> Observable<String>
}
