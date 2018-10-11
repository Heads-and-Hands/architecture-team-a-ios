//
//  PhoneValidator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHInputField

class PhoneTextValidator: ARCHTextValidatorProtocol {

    func validate(text: String) -> ARCHTextValidationResult {

        if text.isEmpty {
            return ARCHTextValidationResult(isValid: false, error: "The field must not be empty")
        }

        let phoneRegexp = """
^\\s*(?:\\+?(\\d{1}))?[-. (]*(\\d{3})[-. )]*(\\d{4})[-. ]*[-. )]*(\\d{2})[-. ]*[-. )]*(\\d{2})[-. ]*\\s*$
"""
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegexp)

        if phonePredicate.evaluate(with: text) {
            return ARCHTextValidationResult(isValid: true, error: "")
        }

        return ARCHTextValidationResult(isValid: false, error: "Phone is invalid")
    }
}
