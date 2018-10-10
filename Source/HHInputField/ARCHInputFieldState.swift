//
//  ARCHInputFieldState.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

import HHModule

public class ARCHInputFieldState: ARCHState {

    public var validationResult: ARCHValidationResult = ARCHValidationResult(isValid: true, errorDescription: "")
    public var value: String = "Value"
    public var placeholder: String = "Placeholder"
    public var label: String = "Label"

    // MARK: - Initializer

    required public init() {}

    // MARK: - Public

    public func update(with state: ARCHInputFieldState) {
        self.validationResult = state.validationResult
        self.value = state.label
        self.placeholder = state.placeholder
        self.label = state.label
    }
}
