//
//  Dictionary+.swift
//  UtilsManifests
//
//  Created by 오현택 on 5/16/24.
//

import Foundation

extension Dictionary {
    public func toJsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error converting dictionary to JSON string: \(error.localizedDescription)")
            return nil
        }
    }
    public func toJSON() -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return jsonData
        } catch {
            print("Error converting dictionary to JSON: \(error.localizedDescription)")
        }
        return nil
    }
}

