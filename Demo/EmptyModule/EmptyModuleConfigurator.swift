//
//  EmptyModuleConfigurator.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

typealias EmptyModuleIO = (inout EmptyModuleModuleInput) -> Void

final class EmptyModuleConfigurator: ARCHModuleConfigurator {

    let moduleIO: EmptyModuleIO?

    init(moduleIO: EmptyModuleIO?) {
        self.moduleIO = moduleIO
    }

    var module: ARCHModule {
        let controller = EmptyModuleViewController()
        controller.output = {
            let eventHandler = EmptyModuleEventHandler()
            eventHandler.router = controller
            eventHandler.viewInput = controller
            return eventHandler
        }()

        if var moduleInput = controller.moduleInput as? EmptyModuleModuleInput {
            moduleIO?(&moduleInput)
        }

        return controller
    }
}
