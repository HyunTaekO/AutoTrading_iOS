//
//  FirebaseCollections.swift
//  Manifests
//
//  Created by 오현택 on 5/23/24.
//

import Foundation

public enum FireStoreCollection: String {
    case CandleData
    
    var name: String {
        return self.rawValue
    }
}
