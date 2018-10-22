//
//  ContainerParentConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerParentConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ContainerParentModuleInput) -> ContainerParentModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ContainerParentViewController()

        let eventHandler = ContainerParentEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        ContainerChildConfigurator(moduleIO: nil).router.transit(from: controller, options: [ARCHRouterBuildInOptions()], animated: true)

        return controller
    }
}
