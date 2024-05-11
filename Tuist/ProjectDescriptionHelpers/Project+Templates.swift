import ProjectDescription

public enum ModuleType: String, CaseIterable {
    case CoinRichApp
    case Data
    case Domain
    case Wallet
    case RealTrading
    case Simulater
    case UpbitAPIService
    
    public var path: Path {
        switch self {
        case .Wallet, .RealTrading, .Simulater:
            return "CoinRich/Modules/Features/\(self.rawValue)"
        default:
            return "CoinRich/Modules/\(self.rawValue)"
        }
    }
}

public extension ModuleType {
    var dependencies: [TargetDependency] {
        switch self {
        case .CoinRichApp:
            return [
                .with(.Data),
                .with(.Wallet),
                .with(.RealTrading),
                .with(.Simulater)
            ]
        case .Data:
            return [
                .with(.Domain),
                .with(.UpbitAPIService),
                .external(name: "RxSwift")
            ]
        case .Domain:
            return [
                .external(name: "RxSwift")
            ]
        case .Wallet:
            return [
                .with(.Domain),
                .external(name: "RxSwift")
            ]
        case .RealTrading:
            return [
                .with(.Domain),
                .external(name: "RxSwift")
            ]
        case .Simulater:
            return [
                .with(.Domain),
                .external(name: "RxSwift")
            ]
        case .UpbitAPIService:
            return [
                .external(name: "RxSwift"),
                .external(name: "SwiftJWT"),
                .external(name: "Alamofire")
            ]
        }
    }
}

let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "UpbitSecretKey": "$(UPBIT_API_SECRET_KEY)",
    "UpbitAccessKey": "$(UPBIT_API_ACCESS_KEY)"
]

public extension Project {
    
    static func app(_ type: ModuleType) -> Project {
        let name = type.rawValue
        let dependencies = type.dependencies
        let target = makeAppTargets(name: name, destinations: .iOS, dependencies: dependencies)
        return Project(name: name,
                       organizationName: "CoinRichHt.com",
                       targets: target)
    }
    
    static func framework(_ type: ModuleType) -> Project {
        let name = type.rawValue
        
        let dependencies = type.dependencies
        let targets = type == .UpbitAPIService ? apiFramework(name: name, destinations: .iOS, dependencies: dependencies) : makeFrameworkTargets(name: name, destinations: .iOS, dependencies: dependencies)
       
        return Project(name: name,
                       organizationName: "CoinRichHt.com",
                       targets: targets)
    }
    
    // MARK: - Private
    
    private static func makeFrameworkTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                           destinations: .iOS,
                           product: .framework,
                           bundleId: "com.ht.CoinRichHt\(name)",
                           infoPlist: .extendingDefault(with: infoPlist),
                           sources: ["Sources/**"],
                           resources: [],
                           dependencies: dependencies
                      )
        
        let tests = Target(name: "\(name)Tests",
                           destinations: destinations,
                           product: .unitTests,
                           bundleId: "com.ht.\(name)Tests",
                           infoPlist: .extendingDefault(with: infoPlist),
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        return [sources, tests]
    }
    
    private static func apiFramework(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                            destinations: .iOS,
                            product: .framework,
                            bundleId: "com.ht.CoinRichHt\(name)",
                            infoPlist: .extendingDefault(with: infoPlist),
                            sources: ["Sources/**"],
                            resources: [],
                            dependencies: dependencies,
                            settings: .settings(configurations: [
                                .debug(name: "Debug", xcconfig: .relativeToRoot("CoinRich/Modules/UpbitAPIService/Sources/APIKey/Secrets.xcconfig")),
                                .release(name: "Release", xcconfig: .relativeToRoot("CoinRich/Modules/UpbitAPIService/Sources/APIKey/Secrets.xcconfig"))
                            ])
        )
        let tests = Target(name: "\(name)Tests",
                           destinations: destinations,
                           product: .unitTests,
                           bundleId: "com.ht.\(name)Tests",
                           infoPlist: .extendingDefault(with: infoPlist),
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)],
                           settings: .settings(configurations: [
                            .debug(name: "Debug", xcconfig: .relativeToRoot("CoinRich/Modules/UpbitAPIService/Sources/APIKey/Secrets.xcconfig")),
                            .release(name: "Release", xcconfig: .relativeToRoot("CoinRich/Modules/UpbitAPIService/Sources/APIKey/Secrets.xcconfig"))
                           ])
        )
        return [sources, tests]
    }
    
    private static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
        
        let mainTarget = Target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.CoinRichHt.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: [],
            dependencies: dependencies
        )
        
//        let testTarget = Target(
//            name: "\(name)Tests",
//            destinations: destinations,
//            product: .unitTests,
//            bundleId: "com.ht.\(name)Tests",
//            infoPlist: .default,
//            sources: ["Targets/\(name)/Tests/**"],
//            dependencies: [
//                .target(name: "\(name)")
//            ])
        return [mainTarget]
    }
    
}

public extension TargetDependency {
    static func with(_ type: ModuleType) -> Self {
        let name = type.rawValue
        var path = ""
        
        switch type {
        case .Wallet, .RealTrading, .Simulater:
            path = "CoinRich/Modules/Features/\(name)"
        default:
            path = "CoinRich/Modules/\(name)"
        }
  
        return TargetDependency.project(target: name, path: .relativeToRoot(path))
    }
}

