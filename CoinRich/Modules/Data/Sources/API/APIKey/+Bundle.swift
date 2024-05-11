//
//  +Bundle.swift
//
//  Created by 오현택 on 5/12/24.
//

import Foundation

extension Bundle {
    
    var upbitSecretKey: String? {
        let bundle = Bundle(identifier: "com.ht.UpbitAPIServiceTests")
        
        guard let resource = bundle?.infoDictionary
        else {
            fatalError("⛔️ File을 찾는데 실패하였습니다.")
        }
        guard let key = resource["UpbitSecretKey"] as? String else {
            fatalError("⛔️ Secret KEY를 가져오는데 실패하였습니다.")
        }
        return key
    }
    
    var upbitAccessKey: String? {
        let bundle = Bundle(identifier: "com.ht.UpbitAPIServiceTests")
        
        guard let resource = bundle?.infoDictionary
        else {
            fatalError("⛔️ File을 찾는데 실패하였습니다.")
        }
        guard let key = resource["UpbitAccessKey"] as? String else {
            fatalError("⛔️ Secret KEY를 가져오는데 실패하였습니다.")
        }
        return key
    }
    
}
