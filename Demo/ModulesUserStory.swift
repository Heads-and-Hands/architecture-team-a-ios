//
//  ModulesUserStory.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

enum ModulesUserStory: ARCHModuleID {
    case emptyModule(
        moduleIO: ((EmptyModuleModuleInput) -> EmptyModuleModuleOutput?)?
    )
    case list(
        moduleIO: ((ListModuleInput) -> ListModuleOutput?)?
    )
    case listExt(
        moduleIO: ((ListExtModuleInput) -> ListExtModuleOutput?)?
    )

    var configurator: ARCHModuleConfigurator {
        switch self {
        case let .emptyModule(moduleIO):
            return EmptyModuleConfigurator(moduleIO: moduleIO)
        case let .list(moduleIO):
            return ListConfigurator(moduleIO: moduleIO)
        case let .listExt(moduleIO):
            return ListExtConfigurator(moduleIO: moduleIO)
        }
    }
}
