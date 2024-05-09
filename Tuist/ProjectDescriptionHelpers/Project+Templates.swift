import ProjectDescription

public enum ModuleType: String, CaseIterable {
    case App
    case Data
    case Domain
    case Presenter
    
    var dependencies: [TargetDependency] {
        switch self {
        case .App:
            return [
                .with(.Data),
                .with(.Presenter)
            ]
        case .Data:
            return [
                .with(.Domain)
            ]
        case .Domain:
            return []
        case .Presenter:
            return [
                .with(.Domain)
            ]
        }
    }
}

private let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]


public extension Project {
    
    static func app(name: String, destinations: Destinations, additionalTargets: [String]) -> Project {
        var targets = makeAppTargets(name: name,
                                     destinations: destinations, dependencies: additionalTargets.map {TargetDependency.target(name: $0)})
        
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, destinations: destinations) })
        return Project(name: name,
                       organizationName: "ht.com",
                       targets: targets)
    }
    
    static func app(_ type: ModuleType) -> Project {
        let name = type.rawValue
        let dependencies = type.dependencies
        return Project(name: name,
                       organizationName: "ht.com",
                       targets: [
                        Target(name: name,
                               destinations: .iOS,
                               product: .app,
                               bundleId: "com.ht.\(name)",
                               infoPlist: .extendingDefault(with: infoPlist),
                               sources: ["Sources/**"],
                               resources: ["Resources/**"],
                               dependencies: dependencies
                              )
                       ])
    }
    
    static func framework(_ type: ModuleType) -> Project {
        let name = type.rawValue
        let dependencies = type.dependencies
        return Project(name: name,
                       organizationName: "ht.com",
                       targets: [
                        Target(name: name,
                               destinations: .iOS,
                               product: .framework,
                               bundleId: "com.ht.\(name)",
                               infoPlist: .extendingDefault(with: infoPlist),
                               sources: ["Sources/**"],
                               resources: ["Resources/**"],
                               dependencies: dependencies
                              )
                       ])
    }
    
    // MARK: - Private
    
    private static func makeFrameworkTargets(name: String, destinations: Destinations) -> [Target] {
        let sources = Target(name: name,
                             destinations: destinations,
                             product: .framework,
                             bundleId: "com.ht.\(name)",
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: [],
                             dependencies: [])
        let tests = Target(name: "\(name)Tests",
                           destinations: destinations,
                           product: .unitTests,
                           bundleId: "com.ht.\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        return [sources, tests]
    }
    
    private static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
        
        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
        ]
        
        let mainTarget = Target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.ht.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "com.ht.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
    
}

public extension TargetDependency {
    static func with(_ type: ModuleType) -> Self {
        let name = type.rawValue
        return TargetDependency.project(target: name, path: .relativeToRoot("CoinRich/Sources/\(name)"))
    }
}

