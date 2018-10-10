//
//  ARCHInputFieldEventHandler.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

open class ARCHInputFieldEventHandler: ARCHEventHandler<ARCHInputFieldState>, ARCHInputFieldViewOutput, ARCHInputFieldInput {

    private weak var internalModuleOutput: ARCHInputFieldOutput?
    open var moduleOutput: AnyObject? {
        set {
            internalModuleOutput = newValue as? ARCHInputFieldOutput
        }
        get {
            return internalModuleOutput
        }
    }

    public var validator: ARCHValidatorProtocol?
    public var formatter: ARCHTextFormatterProtocol?

    override open func viewIsReady() {
        super.viewIsReady()
    }

    // MARK: - ARCHInputFieldInput

    public func set(state: ARCHInputFieldState) {
        self.viewInput?.update(state: state)
    }

    // MARK: - ARCHInputFieldViewOutput

    public func shouldChange(text: String) {

        self.beginStateChanges()
        self.state.value = formatter?.format(text: text) ?? text
        self.state.validationResult = validator?
            .validate(text: self.state.value) ?? ARCHValidationResult(isValid: true, errorDescription: "")
        self.commitStateChanges()
    }
}
