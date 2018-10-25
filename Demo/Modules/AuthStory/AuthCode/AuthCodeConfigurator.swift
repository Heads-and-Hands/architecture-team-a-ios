//
//  AuthCodeConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class AuthCodeConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (AuthCodeModuleInput) -> AuthCodeModuleOutput?

    static func configure(moduleIO: ((AuthCodeModuleInput) -> AuthCodeModuleOutput?)?) -> ARCHRouter {
        let controller = AuthCodeViewController(moduleID: moduleID)

        let eventHandler = AuthCodeEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
