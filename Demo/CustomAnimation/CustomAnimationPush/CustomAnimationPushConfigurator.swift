//
//  CustomAnimationPushConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPushConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (CustomAnimationPushModuleInput) -> CustomAnimationPushModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = CustomAnimationPushViewController<CustomAnimationPushEventHandler>()

        let eventHandler = CustomAnimationPushEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}