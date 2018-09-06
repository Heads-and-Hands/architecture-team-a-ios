//
//  CustomAnimationMainConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationMainConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (CustomAnimationMainModuleInput) -> CustomAnimationMainModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = CustomAnimationMainViewController<CustomAnimationMainEventHandler>()

        let eventHandler = CustomAnimationMainEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
