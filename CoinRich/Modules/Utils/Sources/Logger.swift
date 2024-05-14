//
//  Logger.swift
//  Manifests
//
//  Created by 오현택 on 5/15/24.
//

import Foundation

public enum Logger {
    public static func print(_ items: Any,_ description: String? = nil) {
        #if DEBUG
        Swift.print("🟢START🟢")
        if let description = description {
            Swift.print("설명: ")
            Swift.print(description)
            Swift.print("ㅡㅡValueㅡㅡ")
        }
        Swift.print(items)
        Swift.print("🟢END🟢")
        #endif
    }
}
