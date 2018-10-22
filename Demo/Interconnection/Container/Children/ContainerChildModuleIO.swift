//
//  ContainerChildModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol ContainerChildModuleInput: ARCHModuleInput {
}

protocol ContainerChildModuleOutput: ARCHChildModuleOutput {
}

protocol ContainerChildModuleViewOutput: class {

    func chageTextButtonDidTap()
}
