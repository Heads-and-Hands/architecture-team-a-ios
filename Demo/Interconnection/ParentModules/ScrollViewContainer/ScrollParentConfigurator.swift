//
//  ScrollParentConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ScrollParentConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (ScrollParentModuleInput) -> ScrollParentModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ScrollParentViewController()

        let eventHandler = ScrollParentEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth"].forEach({
            self.registerChildModule(for: $0, router: controller, input: eventHandler)
        })

        return controller
    }

    func registerChildModule(for reuseIdentifire: String, router: ARCHRouter, input: ARCHModuleInput) {
        var id = UUID()
        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            input.registerChildModule(moduleInput, for: reuseIdentifire)
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: router, options: [ARCHRouterBuildInOptions(id: id)], animated: true)
    }
}
