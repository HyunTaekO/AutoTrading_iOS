import ProjectDescription

public enum ModuleType: String, CaseIterable {
    case CoinRichApp
    case Data
    case Domain
    case Wallet
    case RealTrading
    case Simulater
    case Utils
    
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
        let commonDependency: [TargetDependency] = [
            .external(name: "RxSwift"),
            .external(name: "RxBlocking"),
            .external(name: "RxCocoa"),
            .external(name: "RxRelay"),
            .external(name: "RxTest"),
            .with(.Utils)
        ]
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
                .external(name: "SwiftJWT"),
                .external(name: "Alamofire"),
            ]
        case .Domain:
            return commonDependency
        case .Wallet:
            return [
                .with(.Domain),
            ] + commonDependency
        case .RealTrading:
            return [
                .with(.Domain),
            ] + commonDependency
        case .Simulater:
            return [
                .with(.Domain),
            ] + commonDependency
        case .Utils:
            return []
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
        var targets: [Target] = []
        
        switch type {
        case .Data:
            targets = apiFramework(name: name, dependencies: dependencies)
        case .Utils:
            targets.append(makeFrameworkTargets(name: name, dependencies: dependencies))
        default:
            targets.append(makeFrameworkTargets(name: name, dependencies: dependencies))
            targets.append(makeFrameworkTestTargets(name: name))
        }
       
        return Project(name: name,
                       organizationName: "CoinRichHt.com",
                       targets: targets
        )
    }
    
    // MARK: - Private
    
    private static func makeFrameworkTargets(name: String, dependencies: [TargetDependency]) -> Target {
        let sources = Target(name: name,
                           destinations: .iOS,
                           product: .framework,
                           bundleId: "com.ht.CoinRichHt\(name)",
                           infoPlist: .extendingDefault(with: infoPlist),
                           sources: ["Sources/**"],
                           resources: [],
                           dependencies: dependencies
                      )
        
        return sources
    }
    
    private static func makeFrameworkTestTargets(name: String) -> Target {
        let tests = Target(name: "\(name)Tests",
                           destinations: .iOS,
                           product: .unitTests,
                           bundleId: "com.ht.\(name)Tests",
                           infoPlist: .default,
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        return tests
    }
    
    private static func apiFramework(name: String, dependencies: [TargetDependency]) -> [Target] {
        let sources = Target(name: name,
                            destinations: .iOS,
                            product: .framework,
                            bundleId: "com.ht.CoinRichHt\(name)",
                            infoPlist: .extendingDefault(with: infoPlist),
                            sources: ["Sources/**"],
                            resources: [],
                            dependencies: dependencies,
                            settings: .settings(configurations: [
                                .debug(name: "Debug", xcconfig: .relativeToRoot("CoinRich/Modules/Data/Sources/API/Keys/Secrets.xcconfig")),
                                .release(name: "Release", xcconfig: .relativeToRoot("CoinRich/Modules/Data/Sources/API/Keys/Secrets.xcconfig"))
                            ])
        )
        let tests = Target(name: "\(name)Tests",
                           destinations: .iOS,
                           product: .unitTests,
                           bundleId: "com.ht.\(name)Tests",
                           infoPlist: .extendingDefault(with: infoPlist),
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)],
                           settings: .settings(configurations: [
                            .debug(name: "Debug", xcconfig: .relativeToRoot("CoinRich/Modules/Data/Sources/API/Keys/Secrets.xcconfig")),
                            .release(name: "Release", xcconfig: .relativeToRoot("CoinRich/Modules/Data/Sources/API/Keys/Secrets.xcconfig"))
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

