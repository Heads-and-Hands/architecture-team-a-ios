//
//  ContainerParentModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol ContainerParentModuleInput: ARCHModuleInput {
}

protocol ContainerParentModuleOutput: ARCHModuleOutput {
}

protocol ContainerParentViewOutput {

    func needsChangeChildState()
}
