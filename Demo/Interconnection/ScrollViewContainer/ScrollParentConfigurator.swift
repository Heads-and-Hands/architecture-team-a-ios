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

        var id = UUID()
        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "first")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "second")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "third")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "fourth")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "fifth")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "sixth")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "seventh")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            eventHandler.registerChildModule(moduleInput, for: "eighth")
            id = moduleInput.getState().id
            return nil
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        return controller
    }
}
