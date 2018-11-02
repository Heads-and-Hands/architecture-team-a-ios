//
//  AuthMainConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class AuthMainConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (AuthMainModuleInput) -> AuthMainModuleOutput?


    static func configure(moduleIO: ((AuthMainModuleInput) -> AuthMainModuleOutput?)?) -> ARCHRouter {
        let controller = AuthMainViewController(moduleID: moduleID)

        let eventHandler = AuthMainEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
