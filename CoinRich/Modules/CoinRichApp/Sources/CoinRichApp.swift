//
//  CoinRichApp.swift
//  DomainManifests
//
//  Created by 오현택 on 5/11/24.
//

import Foundation
import SwiftUI
//import Firebase
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct CoinRichApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppContentView()
        }
    }
}

