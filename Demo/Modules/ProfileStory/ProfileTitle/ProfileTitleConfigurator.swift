//
//  ProfileTitleConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ProfileTitleConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ProfileTitleModuleInput) -> ProfileTitleModuleOutput?

    static func configure(moduleIO: ((ProfileTitleModuleInput) -> ProfileTitleModuleOutput?)?) -> ARCHRouter {
        let controller = ProfileTitleViewController(moduleID: moduleID)

        let eventHandler = ProfileTitleEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
