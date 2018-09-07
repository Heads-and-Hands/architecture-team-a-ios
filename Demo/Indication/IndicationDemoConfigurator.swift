//
//  IndicationDemoConfigurator.swift
//  architecture
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class IndicationDemoConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (IndicationDemoModuleInput) -> IndicationDemoModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = IndicationDemoViewController()

        let eventHandler = IndicationDemoEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        eventHandler.stateHandler = stateHandler

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }

    private var stateHandler: ARCHStateHandler<IndicationDemoState> = {
        ARCHStateHandler<IndicationDemoState>(block: { old, new -> IndicationDemoState? in
            var buffer = new

            if old.list?.isEmpty ?? true && !(new.list?.isEmpty ?? true) {
                buffer.indication = nil
            }

            if old.indication == nil && new.indication != nil {
                buffer.list = nil
            }

            return buffer
        })
    }()
}
