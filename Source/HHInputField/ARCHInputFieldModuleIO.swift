//
//  ARCHInputFieldModuleIO.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

import HHModule

public protocol ARCHInputFieldViewOutput: ACRHViewOutput {

    func shouldChange(text: String)
}

public protocol ARCHInputFieldInput {

    func set(state: ARCHInputFieldState)
}

public protocol ARCHInputFieldOutput: class {
}
