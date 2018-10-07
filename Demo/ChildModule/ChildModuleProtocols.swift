//
//  ChildModuleProtocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol ChildModuleViewOutput: ParentModuleViewOutput {

    func childViewNeedsChangeState(_ value: String)
}

protocol ChildModuleInput: ParentModuleInput {
}

protocol ChildModuleOutput: ParentModuleOutput {
}
