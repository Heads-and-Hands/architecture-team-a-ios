//
//  EmptyModuleConfigurator.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

final class EmptyModuleConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (EmptyModuleModuleInput) -> EmptyModuleModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = EmptyModuleViewController()

        let eventHandler = EmptyModuleEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
