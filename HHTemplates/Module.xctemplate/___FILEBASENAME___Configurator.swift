//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import HHModule

final class ___VARIABLE_HandHModuleName___Configurator: ARCHModuleConfigurator {
    typealias ModuleIO = (___VARIABLE_HandHModuleName___ModuleInput) -> ___VARIABLE_HandHModuleName___ModuleOutput?

    let moduleIO: ModuleIO?

    init(moduleIO: ModuleIO?) {
        self.moduleIO = moduleIO
    }

    var router: ARCHRouter {
        let controller = ___VARIABLE_HandHModuleName___ViewController()

        let eventHandler = ___VARIABLE_HandHModuleName___EventHandler()
        eventHandler.router = controller
        eventHandler.viewInput = controller

        if let moduleIO = moduleIO {
            eventHandler.moduleOutput = moduleIO(eventHandler)
        }

        controller.output = eventHandler

        return controller
    }
}
