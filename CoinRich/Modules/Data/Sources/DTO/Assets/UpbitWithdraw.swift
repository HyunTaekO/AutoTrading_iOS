//
//  UpbitWithdraw.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

public struct UpbitWithdraw: Codable {
    
    public let type: String // 출금 종류
    public let uuid: String // 출금의 고유 아이디
    public let currency: String //화폐를 의미하는 영문 대문자 코드
    public let netType: String? //출금 네트워크
    public let txid: String //출금의 트랜잭션 아이디
    public let state: String //출금 상태
    public let createdAt: String //출금 생성 시간
    public let doneAt: String? //출금 완료 시간
    public let amount: String //출금 금액/수량
    public let fee: String //출금 수수료
    public let transactionType: String // 출금 유형 default : 일반출금 / internal : 바로출금
    
    enum CodingKeys: String, CodingKey {
        case type, uuid, currency, txid, state, amount, fee
        case netType = "net_type"
        case createdAt = "created_at"
        case doneAt = "done_at"
        case transactionType = "transaction_type"
    }
    
}

public typealias UpbitWithdraws = [UpbitWithdraw]
