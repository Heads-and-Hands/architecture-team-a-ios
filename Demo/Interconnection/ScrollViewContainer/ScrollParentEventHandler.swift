//
//  ScrollParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ScrollParentEventHandler: ARCHEventHandler<ScrollParentState>, ScrollParentModuleInput, ScrollParentModuleViewOutput, ContainerChildModuleOutput {

    enum ModuleTag {
        case first, second, third, fourth, fifth, sixth, seventh, eighth
    }

    var childModulesIds: [ModuleTag: UUID] = [:]

    weak var moduleOutput: ScrollParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    func tag(for id: UUID) -> ScrollParentEventHandler.ModuleTag? {
        return childModulesIds.first(where: { $0.value == id })?.key
    }

    // MARK: - ContainerChildModuleOutput

    func didChange(childState: ARCHState) {
        updateState(with: childState)
    }

    // MARK: - Private

    private func updateState(with childState: ARCHState) {
        let index = state.childStates.index(where: { $0.id == childState.id }) ?? 0
        beginStateChanges()
        state.childStates[index] = childState
        commitStateChanges()
    }
}
