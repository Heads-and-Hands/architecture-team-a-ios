//
//  HHModuleTestsConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 05/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class Configurator<T: TestState>: ARCHModuleConfigurator {

    var router: ARCHRouter {
        let controller = ViewController<EventHandler<T>, T>()

        let eventHandler = EventHandler<T>()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        controller.output = eventHandler

        return controller
    }
}
