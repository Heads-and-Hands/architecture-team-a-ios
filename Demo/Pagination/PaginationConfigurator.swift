//
//  PaginationConfigurator.swift
//  architecture
//
//  Created by basalaev on 20.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHPagingManager

final class PaginationConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (PaginationModuleInput) -> PaginationModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = PaginationViewController()

        let eventHandler = PaginationEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        eventHandler.apiProvider = Dependency.shared.apiProvider

        let pagingManager = ARCHTableViewPagingManager()
        pagingManager.output = eventHandler
        controller.pagingManager = pagingManager

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
