//
//  ContainerParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

enum ChildModuleTag {
    case first
}

final class ContainerParentEventHandler: ARCHEventHandler<ContainerParentState>, ContainerParentModuleInput, ARCHChildModuleOutput, ContainerParentViewOutput, ContainerChildModuleOutput {

    var childModulesIds: [ChildModuleTag: UUID] = [:]

    weak var moduleOutput: ContainerParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()

        if var childState = childState(for: .first) as? ContainerChildState {
            childState.text = UUID().uuidString
            updateState(with: childState)
        }
    }

    func needsChangeChildState() {
        if var childState = childState(for: .first) as? ContainerChildState {
            childState.text = UUID().uuidString
            updateState(with: childState)
        }
    }

    // MARK: - ARCHChildModuleOutput

    func didChange(childState: ARCHState) {
        updateState(with: childState)
    }

    // MARK: - Private

    private func updateState(with childState: ARCHState) {
        let index = state.childStates.index(where: { $0.id == childState.id }) ?? 0
        beginStateChanges()
        state.childTitle = (childState as? ContainerChildState)?.text ?? ""
        state.childStates[index] = childState
        commitStateChanges()
    }

    private func childState(for tag: ChildModuleTag) -> ARCHState? {
        guard let uuid = childModulesIds[tag] else {
            return nil
        }

        return childState(for: uuid)
    }

    private func childState(for id: UUID) -> ARCHState? {
        return state.childStates.first(where: { $0.id == id })
    }
}
