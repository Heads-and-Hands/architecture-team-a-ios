//
//  EmptyModuleConfigurator.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHInputField

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

        ARCHInputFieldConfigurator(moduleIO: { (moduleInput: ARCHInputFieldInput) -> ARCHInputFieldOutput? in
            var input = moduleInput
            let state = ARCHInputFieldState()
            state.label = "Email"
            state.placeholder = "Enter your email"
            input.set(state: state)
            input.validator = EmailTextValidator()
            eventHandler.register(field: .name, id: input.id, input: input)
            return eventHandler
        }, viewController: TextFieldController()).router.transit(
            from: controller,
            options: [ARCHRouterBuildInOptions(container: controller.emailFieldContainer)],
            animated: false)

        ARCHInputFieldConfigurator(moduleIO: { (moduleInput: ARCHInputFieldInput) -> ARCHInputFieldOutput? in
            var input = moduleInput
            let state = ARCHInputFieldState()
            state.label = "Name"
            state.placeholder = "Enter your name"
            input.set(state: state)
            input.validator = EmptyTextValidator()
            eventHandler.register(field: .email, id: input.id, input: input)
            return eventHandler
        }, viewController: TextFieldController()).router.transit(
            from: controller,
            options: [ARCHRouterBuildInOptions(container: controller.nameFieldContainer)],
            animated: false)

        ARCHInputFieldConfigurator(moduleIO: { (moduleInput: ARCHInputFieldInput) -> ARCHInputFieldOutput? in
            var input = moduleInput
            let state = ARCHInputFieldState()
            state.label = "Phone"
            state.placeholder = "Enter your phone"
            input.set(state: state)
            input.validator = PhoneTextValidator()
            input.formatter = PhoneTextFormatter()
            eventHandler.register(field: .phone, id: input.id, input: input)
            return eventHandler
        }, viewController: TextFieldController()).router.transit(
            from: controller,
            options: [ARCHRouterBuildInOptions(container: controller.phoneFieldContainer)],
            animated: false)

        return controller
    }
}
