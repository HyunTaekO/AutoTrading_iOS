//
//  Dictionary+.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

extension Data {
    // JSON 데이터 -> DTO Struct
    public func toObject<T>(_ type: T.Type) -> T? where T: Decodable {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        }catch {
            Logger.print(error, "Decoding error")
        }
        return try? JSONDecoder().decode(T.self, from: self)
    }
    // JSON 데이터 출력
    public func printJsonString() throws {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            if let prettyJsonString = String(data: prettyJsonData, encoding: .utf8) {
                Logger.print(prettyJsonString, "JSON 데이터 출력")
            } else {
                Logger.print("JSON 데이터 변환 실패")
            }
        } catch {
            Logger.print(error, "JSON 데이터 역직렬화 실패")
        }
    }
}


