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
        Swift.print()
        Swift.print("🟢START🟢")
        if let description = description {
            Swift.print("[ \(description) ]")
            Swift.print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
        }
        Swift.print(items)
        Swift.print("🟢END🟢")
        Swift.print()
        #endif
    }
    
    public static func errorPrint(_ description: String,_ items: Any? = nil) {
        #if DEBUG
        Swift.print()
        Swift.print("❌ERROR❌")
        Swift.print(description)
        if let items = items {
            Swift.print("ㅡㅡValueㅡㅡ")
            Swift.print(items)
        }
        Swift.print("❌END❌")
        Swift.print()
        #endif
    }
}
