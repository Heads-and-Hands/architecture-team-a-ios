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

        var childModulesStates: [ARCHState] = []
        var id: UUID = UUID()

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.first] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.second] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.third] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.fourth] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.fifth] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.sixth] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.seventh] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        ContainerChildConfigurator(moduleIO: { (moduleInput: ContainerChildModuleInput) -> ContainerChildModuleOutput? in
            let childState = moduleInput.getState()
            childModulesStates.append(childState)
            eventHandler.childModulesIds[.eighth] = childState.id
            id = childState.id
            return eventHandler
        }).router.transit(from: controller, options: [ARCHRouterBuildInOptions(id: id)], animated: true)

        eventHandler.state.childStates = childModulesStates

        return controller
    }
}
