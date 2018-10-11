//
//  EmailTextValidator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHInputField

class EmailTextValidator: ARCHTextValidatorProtocol {

    func validate(text: String) -> ARCHTextValidationResult {

        if text.isEmpty {
            return ARCHTextValidationResult(isValid: false, error: "The field must not be empty")
        }

        let emailRegexp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexp)

        if emailPredicate.evaluate(with: text) {
            return ARCHTextValidationResult(isValid: true, error: "")
        }

        return ARCHTextValidationResult(isValid: false, error: "Email is invalid")
    }
}
