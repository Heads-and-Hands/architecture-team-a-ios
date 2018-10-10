//
//  ARCHInputFieldProtocols.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public struct ARCHTextValidationResult {

    public var isValid: Bool
    public var errorDescription: String

    public init(isValid: Bool, error: String) {
        self.isValid = isValid
        self.errorDescription = error
    }
}

public protocol ARCHTextValidatorProtocol {

    func validate(text: String) -> ARCHTextValidationResult
}

public protocol ARCHTextFormatterProtocol {

    func format(text: String) -> String
}
