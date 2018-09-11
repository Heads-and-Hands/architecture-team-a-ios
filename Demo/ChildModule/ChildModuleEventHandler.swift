//
//  ChildModuleEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ChildModuleEventHandler: ParentModuleEventHandler<ChildModuleState>, ChildModuleViewOutput, ChildModuleInput {

    weak var childModuleOutput: ChildModuleOutput?
    override var moduleOutput: AnyObject? {
        set {
            childModuleOutput = newValue as? ChildModuleOutput
        }
        get {
            return childModuleOutput
        }
    }

    override func viewIsReady() {
        super.viewIsReady()
    }

    func childViewNeedsChangeState(_ value: String) {
        state.childPrimitiveState.text = value
    }
}
