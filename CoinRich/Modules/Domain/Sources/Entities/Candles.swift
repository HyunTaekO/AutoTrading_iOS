//
//  Candles.swift
//  DomainManifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation

public enum CandleType {
    case minute(MinuteCandle)
    case hour(HourCandle)
    case days
    case weeks
    case months
    
    public init(value: String,
                minuteCandle: MinuteCandle? = .one,
                hourCandle: HourCandle? = .one) {
        switch value {
        case "분":
            if let candle = minuteCandle {
                self = .minute(candle)
            } else {
                self = .minute(.one)
            }
        case "시":
            if let candle = hourCandle {
                self = .hour(candle)
            } else {
                self = .hour(.one)
            }
        case "일": self = .days
        case "주": self = .weeks
        case "월": self = .months
        default:    self = .minute(.one)
        }
    }
}

public enum MinuteCandle: Int {
    case one = 1
    case three = 3
    case five = 5
    case ten = 10
    case fifteen = 15
    case thirty = 30
    
    public init(value: String) {
        switch value {
        case "1": self = .one
        case "3": self = .three
        case "5": self = .five
        case "10": self = .ten
        case "15": self = .fifteen
        case "30": self = .thirty
        default:    self = .one
        }
    }
    
    public init(value: Int) {
        switch value {
        case 1: self = .one
        case 3: self = .three
        case 5: self = .five
        case 10: self = .ten
        case 15: self = .fifteen
        case 30: self = .thirty
        default:    self = .one
        }
    }
}

public enum HourCandle: Int {
    case one = 60
    case four = 240
    
    public init(value: String) {
        switch value {
        case "60": self = .one
        case "240": self = .four
        default:    self = .one
        }
    }
    
    public init(value: Int) {
        switch value {
        case 60: self = .one
        case 240: self = .four
        default:    self = .one
        }
    }
}
