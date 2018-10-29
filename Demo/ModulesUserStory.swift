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
#if HHModule
    case main(EmptyModuleIO)
#else
    case main
#endif

    var configurator: ARCHModuleConfigurator {
        switch self {
#if HHModule
        case let .main(moduleIO):
            return EmptyModuleConfigurator(moduleIO: moduleIO)
#else
        case .main:
            fatalError()
#endif
/*
#if HHList
            return ListConfigurator(moduleIO: nil)
#elseif HHSectionList
            return SectionListConfigurator(moduleIO: nil)
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
*/
        }
    }
}
