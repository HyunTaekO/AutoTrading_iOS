//
//  Workspace.swift
//  Manifests
//
//  Created by 오현택 on 5/10/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projects: [Path] = ModuleType.allCases.map { $0.path }

let workspace = Workspace(
    name: "CoinRich",
    projects: projects
)
