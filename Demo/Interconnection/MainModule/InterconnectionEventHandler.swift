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
    }

    func didTapScrollViewContainter() {
    }

    func didTapSectionTableContainer() {
    }

    func didTapRowTableContainer() {
    }
}
