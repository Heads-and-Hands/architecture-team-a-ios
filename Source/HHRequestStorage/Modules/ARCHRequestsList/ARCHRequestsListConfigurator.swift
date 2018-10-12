//
//  ARCHRequestsListConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsListConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ARCHRequestsListModuleInput) -> ARCHRequestsListModuleOutput?

    let moduleIO: ModuleIO?
    let storage: ARCHRequestStorageProtocol?

    init(moduleIO: ModuleIO?, storage: ARCHRequestStorageProtocol) {
        self.moduleIO = moduleIO
        self.storage = storage
    }

    var router: ARCHRouter {
        let controller = ARCHRequestsListViewController()

        let eventHandler = ARCHRequestsListEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        eventHandler.storage = storage

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
