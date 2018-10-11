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

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ARCHRequestStorageViewController()

        let eventHandler = ARCHRequestStorageEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
