//
//  ListExtConfigurator.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ListExtConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ListExtModuleInput) -> ListExtModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ListExtViewController()

        let eventHandler = ListExtEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
