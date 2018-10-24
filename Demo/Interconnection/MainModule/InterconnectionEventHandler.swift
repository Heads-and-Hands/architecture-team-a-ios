//
//  InterconnectionEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class InterconnectionEventHandler: ARCHEventHandler<InterconnectionState>, InterconnectionModuleInput, InterconnectionModuleViewOutput {

    weak var moduleOutput: InterconnectionModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    // MARK: - InterconnectionModuleViewOutput

    func didTapModuleContainer() {
        ContainerParentConfigurator(moduleIO: nil)
            .router
            .transit(from: router, options: [ARCHRouterPresentOptions()], animated: true)
    }

    func didTapScrollViewContainter() {
        ScrollParentConfigurator(moduleIO: nil)
            .router
            .transit(from: router, options: [ARCHRouterPresentOptions()], animated: true)
    }

    func didTapSectionTableContainer() {
        SectionParentConfigurator(moduleIO: nil)
            .router
            .transit(from: router, options: [ARCHRouterPresentOptions()], animated: true)
    }
    
    func didTapRowTableContainer() {
        CellParentConfigurator(moduleIO: nil)
            .router
            .transit(from: router, options: [ARCHRouterPresentOptions()], animated: true)
    }
}
