//
//  ParentModuleEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class ParentModuleEventHandler<S: ParentModuleStateProtocol>: ARCHEventHandler<S>, ParentModuleViewOutput, ParentModuleInput {

    weak var internalModuleOutput: ParentModuleOutput?
    open var moduleOutput: AnyObject? {
        set {
            internalModuleOutput = newValue as? ParentModuleOutput
        }
        get {
            return internalModuleOutput
        }
    }

    override func viewIsReady() {
        super.viewIsReady()
    }

    func parentViewNeedsChangeState(_ text: String) {
        state.parentPrimitiveState.text = text
    }
}
