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

    public var validationResult: ARCHTextValidationResult = ARCHTextValidationResult(isValid: true, error: "")
    public var value: String = ""
    public var placeholder: String = ""
    public var label: String = ""

    // MARK: - Initializer

    required public init() {}

    // MARK: - Public

    public func update(with state: ARCHInputFieldState) {
        self.validationResult = state.validationResult
        self.value = state.value
        self.placeholder = state.placeholder
        self.label = state.label
    }
}
