//
//  +Bundle.swift
//  UpbitAPIServiceManifests
//
//  Created by 오현택 on 5/11/24.
//

import Foundation

extension Bundle {
    
    var upbitSecretKey: String? {
        guard let file = self.path(forResource: "UpbitSecretKey", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            print("⛔️ Secret KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
    var upbitAccessKey: String? {
        guard let file = self.path(forResource: "UpbitAccessKey", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            print("⛔️ Access KEY를 가져오는데 실패하였습니다.")
            return nil
        }
        return key
    }
    
}
