//
//  ParentProtocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol ParentModuleViewOutput: ACRHViewOutput {

    func parentViewNeedsChangeState(_ text: String)
}

protocol ParentModuleInput {
}

protocol ParentModuleOutput: class {
}

protocol ParentModuleStateProtocol: ARCHState {

    associatedtype ParentModulePrimitiveState

    var parentPrimitiveState: ParentModulePrimitiveState { get set }
}
