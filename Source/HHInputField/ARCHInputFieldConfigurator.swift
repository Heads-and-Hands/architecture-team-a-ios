//
//  ARCHInputFieldConfigurator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

open class ARCHInputFieldConfigurator: ARCHModuleConfigurator {
    public typealias ModuleIO = (ARCHInputFieldInput) -> ARCHInputFieldOutput?

    let moduleIO: ModuleIO?

    public init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    public var router: ARCHRouter {
        let controller = ARCHInputFieldViewController<ARCHInputFieldEventHandler<ARCHInputFieldState>, ARCHInputFieldState >()
        let eventHandler = ARCHInputFieldEventHandler<ARCHInputFieldState>()
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
