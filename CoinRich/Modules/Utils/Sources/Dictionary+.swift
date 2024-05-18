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
}

