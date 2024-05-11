//
//  Dependencies.swift
//  Manifests
//
//  Created by 오현택 on 5/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    
    swiftPackageManager: .init([
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.5.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMajor(from: "4.0.3")),
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/Kitura/Swift-JWT.git", requirement: .upToNextMajor(from: "3.6.1"))
    ], baseSettings: .settings(
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ])
    ),
    
    platforms: [.iOS]
)
