//
//  ContainerChildEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerChildEventHandler: ARCHEventHandler<ContainerChildState>, ContainerChildModuleInput, ContainerChildModuleViewOutput {

    weak var moduleOutput: ContainerChildModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    // MARK: - ContainerChildModuleViewOutput

    func chageTextButtonDidTap() {
        state.text = UUID().uuidString

        moduleOutput?.didChange(childState: state)
    }
}
