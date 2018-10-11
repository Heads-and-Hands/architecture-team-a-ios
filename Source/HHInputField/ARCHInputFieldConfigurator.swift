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
    let viewController: ARCHInputFieldViewController<ARCHInputFieldEventHandler>?

    public init(moduleIO: ModuleIO?,
                viewController: ARCHInputFieldViewController<ARCHInputFieldEventHandler>?) {
        self.moduleIO = moduleIO
        self.viewController = viewController
    }

    public var router: ARCHRouter {
        let controller = viewController ?? ARCHInputFieldViewController<ARCHInputFieldEventHandler>()
        let eventHandler = ARCHInputFieldEventHandler()
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
