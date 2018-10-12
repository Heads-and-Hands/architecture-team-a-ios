//
//  ARCHRequestStorageConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestStorageConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ARCHRequestStorageModuleInput) -> ARCHRequestStorageModuleOutput?

    let moduleIO: ModuleIO?
    let storage: ARCHRequestStorageProtocol?

    init(moduleIO: ModuleIO?, storage: ARCHRequestStorageProtocol) {
        self.moduleIO = moduleIO
        self.storage = storage
    }

    var router: ARCHRouter {
        let controller = ARCHRequestStorageViewController()

        let eventHandler = ARCHRequestStorageEventHandler()
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
