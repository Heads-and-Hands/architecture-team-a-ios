//
//  PreferencesConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class PreferencesConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (PreferencesModuleInput) -> PreferencesModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = PreferencesViewController()

        let eventHandler = PreferencesEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        eventHandler.preferencesManager = PreferencesManager.shared

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
