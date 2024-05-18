//
//  Array+.swift
//  UtilsManifests
//
//  Created by 오현택 on 5/19/24.
//

import Foundation

extension Array {
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
    public func toJsonData() -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch {
            return nil
        }
    }
}
