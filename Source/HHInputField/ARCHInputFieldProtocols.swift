//
//  ARCHInputFieldProtocols.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 10/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public struct ARCHValidationResult {

    var isValid: Bool
    var errorDescription: String
}

public protocol ARCHValidatorProtocol {

    func validate(text: String) -> ARCHValidationResult
}

public protocol ARCHTextFormatterProtocol {

    func format(text: String) -> String
}
