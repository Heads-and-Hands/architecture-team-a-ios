//
//  SkeletonListConfigurator.swift
//  architecture
//
//  Created by basalaev on 28.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class SkeletonListConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (SkeletonListModuleInput) -> SkeletonListModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = SkeletonListViewController()

        let eventHandler = SkeletonListEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
