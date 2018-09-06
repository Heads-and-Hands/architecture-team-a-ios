
//
//  File.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

enum ModulesCustomAnimationStory: ARCHModuleID {

    case main, push, present

    var configurator: ARCHModuleConfigurator {
        switch self {
        case .main:
            return CustomAnimationMainConfigurator(moduleIO: nil)
        case .push:
            return CustomAnimationPushConfigurator(moduleIO: nil)
        case .present:
            return CustomAnimationPresentConfigurator(moduleIO: nil)
        }
    }
}
