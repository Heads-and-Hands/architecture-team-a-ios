//
//  ModulesUserStory.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation
import HHModule

enum ModulesUserStory: ARCHModuleID {
    case main

    var configurator: ARCHModuleConfigurator {
        switch self {
        case .main:
#if HHModule
//            return ChildModuleConfigurator(moduleIO: nil)
//            return ParentModuleConfigurator(moduleIO: nil)
            return EmptyModuleConfigurator(moduleIO: nil)
#elseif HHList
            return ListConfigurator(moduleIO: nil)
#elseif HHListExtDemo
            return ListExtConfigurator(moduleIO: nil)
#elseif HHNetwork
            return NetworkConfigurator(moduleIO: nil)
#elseif HHPaginationDemo
            return PaginationConfigurator(moduleIO: nil)
#elseif HHIndication
            return IndicationDemoConfigurator(moduleIO: nil)
#elseif HHSkeleton
            return IndicationDemoConfigurator(moduleIO: nil)
#elseif HHLens
            return EmptyModuleConfigurator(moduleIO: nil)
#endif
        }
    }
}
