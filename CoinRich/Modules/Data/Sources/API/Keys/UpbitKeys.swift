//
//  UpbitKeys.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation
import Utils

enum UpbitKeys {
    case access,
         secret
    
    var key: String {
        switch self {
        case .access:
            return Bundle.main.upbitAccessKey ?? ""
        case .secret:
            return Bundle.main.upbitSecretKey ?? ""
        }
    }
}
