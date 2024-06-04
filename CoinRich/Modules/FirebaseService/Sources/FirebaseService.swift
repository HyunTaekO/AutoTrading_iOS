//
//  FirebaseService.swift
//  Manifests
//
//  Created by 오현택 on 5/23/24.
//

import Foundation
import RxSwift

public protocol FirebaseService {
    
    typealias FirebaseData = [String: Any]
    
    // MARK: Methods
    func getDocument(collection: FireStoreCollection) -> Single<[FirebaseData]>
    func getDocument(collection: FireStoreCollection, document: String) -> Single<FirebaseData>
    func getDocument(collection: FireStoreCollection, field: String, condition: [String]) -> Single<[FirebaseData]>
    func getDocument(collection: FireStoreCollection, field: String, in values: [Any]) -> Single<[FirebaseData]>
    func getDocument(documents: [String]) -> Single<FirebaseData>
    func createDocument(collection: FireStoreCollection, document: String, values: FirebaseData) -> Single<Void>
    func createDocument(documents: [String], values: FirebaseData) -> Single<Void>
    func updateDocument(collection: FireStoreCollection, document: String, values: FirebaseData) -> Single<Void>
    func deleteDocument(collection: FireStoreCollection, document: String) -> Single<Void>
    func observer(collection: FireStoreCollection, document: String) -> Observable<FirebaseData>
    func observer(documents: [String]) -> Observable<FirebaseData>
    
    // MARK: - Added
    func getDocuments(documents: [String]) -> Single<[FirebaseData]>
    func observe(documents: [String]) -> Observable<[FirebaseData]>
    func observe(collection: FireStoreCollection, field: String, in values: [Any]) -> Observable<[FirebaseData]>
    func deleteDocument(documents: [String]) -> Single<Void>
    func deleteDocuments(collections: [(FireStoreCollection, String)]) -> Single<Void>

}
