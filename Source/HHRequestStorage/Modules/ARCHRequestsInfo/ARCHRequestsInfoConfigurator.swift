//
//  ARCHRequestsInfoConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsInfoConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ARCHRequestsInfoModuleInput) -> ARCHRequestsInfoModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ARCHRequestsInfoViewController()

        let eventHandler = ARCHRequestsInfoEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
