//
//  ProfileEditConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ProfileEditConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ProfileEditModuleInput) -> ProfileEditModuleOutput?

    static func configure(moduleIO: ((ProfileEditModuleInput) -> ProfileEditModuleOutput?)?) -> ARCHRouter {
        let controller = ProfileEditViewController(moduleID: moduleID)

        let eventHandler = ProfileEditEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
