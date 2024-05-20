//
//  Date+.swift
//  DataManifests
//
//  Created by 오현택 on 5/13/24.
//

import Foundation

extension Date {
    
    public enum Format: String {
        case toCandleFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    public func toString(type: Format) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = type.rawValue
        
        return formatter.string(from: self)
    }

    public static func stringToDate(dateString: String, type: Format) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = type.rawValue

        return formatter.date(from: dateString)
    }

}

