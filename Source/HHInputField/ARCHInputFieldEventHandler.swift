//
//  ARCHInputFieldEventHandler.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

open class ARCHInputFieldEventHandler: ARCHEventHandler<ARCHInputFieldState>, ARCHInputFieldViewOutput, ARCHInputFieldInput {

    public weak var moduleOutput: ARCHInputFieldOutput?

    public var id = UUID().uuidString
    public var validator: ARCHTextValidatorProtocol?
    public var formatter: ARCHTextFormatterProtocol?

    override open func viewIsReady() {
        super.viewIsReady()
    }

    // MARK: - ARCHInputFieldInput

    public func set(state: ARCHInputFieldState) {
        self.state.update(with: state)
        self.viewInput?.update(state: self.state)
    }

    public func set(value: String) {
        self.state.value = value
        self.viewInput?.update(state: self.state)
    }

    // MARK: - ARCHInputFieldViewOutput

    public func shouldChange(text: String) {

        let result = formatter?.format(text: text) ?? text
        let validationResult = validator?.validate(text: result) ?? ARCHTextValidationResult(isValid: true, error: "")

        self.beginStateChanges()
        self.state.value = result
        self.state.validationResult = validationResult
        self.commitStateChanges()

        moduleOutput?.didChangeValue(result, isValid: validationResult.isValid, for: id)
    }
}
