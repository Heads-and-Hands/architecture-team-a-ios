//
//  ContainerParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerParentEventHandler: ARCHEventHandler<ContainerParentState>, ContainerParentModuleInput, ContainerParentViewOutput {

    weak var moduleOutput: ContainerParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()

        if var childState = childState(for: "first") as? ContainerChildState {
            childState.text = UUID().uuidString
            updateState(with: childState)
        }
    }

    func needsChangeChildState() {
        if var childState = childState(for: "first") as? ContainerChildState {
            childState.text = UUID().uuidString
            updateState(with: childState)
        }
    }

    // MARK: - Child state processing

    override func updateState(with childState: ARCHState) {
        super.updateState(with: childState)
        state.childTitle = (childState as? ContainerChildState)?.text ?? ""
    }
}
