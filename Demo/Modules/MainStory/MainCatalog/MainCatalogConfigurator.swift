//
//  MainCatalogConfigurator.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class MainCatalogConfigurator: ARCHModuleConfigurator {
    typealias ModuleIO = (MainCatalogModuleInput) -> MainCatalogModuleOutput?

    static func configure(moduleIO: ((MainCatalogModuleInput) -> MainCatalogModuleOutput?)?) -> ARCHRouter {
        let controller = MainCatalogViewController(moduleID: moduleID)

        let eventHandler = MainCatalogEventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
