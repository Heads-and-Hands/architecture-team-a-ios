//
//  NetworkConfigurator.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHPreferences

final class NetworkConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (NetworkModuleInput) -> NetworkModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = NetworkViewController()

        let eventHandler = NetworkEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller
        eventHandler.apiProvider = Dependency.shared.apiProvider
        eventHandler.preferencesManager = PreferencesManager.shared

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
