//
//  UpbitDesposit.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

public struct UpbitDesposit: Codable {
    
    public let type: String // 입금 종류
    public let uuid: String // 입금의 고유 아이디
    public let currency: String //화폐를 의미하는 영문 대문자 코드
    public let netType: String? //입금 네트워크
    public let txid: String //입금의 트랜잭션 아이디
    public let state: String //입금 상태
    public let createdAt: String //입금 생성 시간
    public let doneAt: String? //입금 완료 시간
    public let amount: String //입금 금액/수량
    public let fee: String //입금 수수료
    public let transactionType: String // 입금 유형 default : 일반입금 / internal : 바로입금
    
    enum CodingKeys: String, CodingKey {
        case type, uuid, currency, txid, state, amount, fee
        case netType = "net_type"
        case createdAt = "created_at"
        case doneAt = "done_at"
        case transactionType = "transaction_type"
    }
    
}

public typealias UpbitDesposits = [UpbitDesposit]
