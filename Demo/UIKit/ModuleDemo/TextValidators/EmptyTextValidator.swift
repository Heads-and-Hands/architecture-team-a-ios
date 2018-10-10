//
//  EmptyTextValidator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHInputField

class EmptyTextValidator: ARCHTextValidatorProtocol {

    func validate(text: String) -> ARCHTextValidationResult {

        if text.isEmpty {
            return ARCHTextValidationResult(isValid: false, error: "The field must not be empty")
        }

        return ARCHTextValidationResult(isValid: true, error: "")
    }
}
