//
//  UpbitDesposit.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

struct UpbitDepositAndWithdraw: Codable {
    
    let type: String // 입출금 종류
    let uuid: String // 입출금의 고유 아이디
    let currency: String //화폐를 의미하는 영문 대문자 코드
    let netType: String? //입출금 네트워크
    let txid: String //입출금의 트랜잭션 아이디
    let state: String //입출금 상태
    let createdAt: String //입출금 생성 시간
    let doneAt: String? //입출금 완료 시간
    let amount: String //입출금 금액/수량
    let fee: String //입출금 수수료
    let transactionType: String // 입출금 유형 - default : 일반입출금 / internal : 바로입출금
    
    enum CodingKeys: String, CodingKey {
        case type, uuid, currency, txid, state, amount, fee
        case netType = "net_type"
        case createdAt = "created_at"
        case doneAt = "done_at"
        case transactionType = "transaction_type"
    }
    
}

typealias UpbitDepositAndWithdraws = [UpbitDepositAndWithdraw]
