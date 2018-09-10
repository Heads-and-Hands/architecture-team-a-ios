//
//  ParentModuleEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class ParentModuleEventHandler: ARCHEventHandler<ParentModuleState>, ParentModuleViewOutput, ParentModuleInput {

    weak var moduleOutput: ParentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    func parentViewNeedsChangeState(_ text: String) {
        state.parentPrimitiveState.text = text
    }
}
