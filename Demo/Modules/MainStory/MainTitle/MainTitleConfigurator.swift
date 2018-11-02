//
//  MainTitleConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class MainTitleConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (MainTitleModuleInput) -> MainTitleModuleOutput?

    static func configure(moduleIO: ((MainTitleModuleInput) -> MainTitleModuleOutput?)?) -> ARCHRouter {
        let controller = MainTitleViewController.init(moduleID: moduleID)

        let eventHandler = MainTitleEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
