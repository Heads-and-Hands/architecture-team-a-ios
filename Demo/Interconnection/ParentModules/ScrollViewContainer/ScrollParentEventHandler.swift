//
//  ScrollParentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ScrollParentEventHandler: ARCHEventHandler<ScrollParentState>, ScrollParentModuleInput, ScrollParentModuleViewOutput, ContainerChildModuleOutput {

    weak var moduleOutput: ScrollParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    override func didChange(childState: ARCHState) {
        super.didChange(childState: childState)

        print("Did changed child state with id \(childState.id.uuidString) to value \((childState as? ContainerChildState)?.text ?? "") ")
    }
}
