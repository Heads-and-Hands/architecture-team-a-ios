//
//  ARCHInputFieldEventHandler.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

open class ARCHInputFieldEventHandler<S: ARCHInputFieldStateProtocol>: ARCHEventHandler<S>, ARCHInputFieldViewOutput, ARCHInputFieldInput {

    private weak var internalModuleOutput: ARCHInputFieldOutput?
    open var moduleOutput: AnyObject? {
        set {
            internalModuleOutput = newValue as? ARCHInputFieldOutput
        }
        get {
            return internalModuleOutput
        }
    }

    override open func viewIsReady() {
        super.viewIsReady()
    }
}
