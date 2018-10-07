//
//  ChildModuleEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ChildModuleEventHandler: ParentModuleEventHandler<ChildModuleState>, ChildModuleViewOutput, ChildModuleInput {

    private weak var internalModuleOutput: ChildModuleOutput?
    override var moduleOutput: AnyObject? {
        set {
            internalModuleOutput = newValue as? ChildModuleOutput
        }
        get {
            return internalModuleOutput
        }
    }

    override func viewIsReady() {
        super.viewIsReady()
    }

    func childViewNeedsChangeState(_ value: String) {
        state.childPrimitiveState.text = value
    }
}
