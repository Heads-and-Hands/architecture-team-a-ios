//
//  InterconnectionModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol InterconnectionModuleInput: ARCHModuleInput  {
}

protocol InterconnectionModuleOutput: ARCHModuleOutput {
}

protocol InterconnectionModuleViewOutput: class {

    func didTapModuleContainer()

    func didTapScrollViewContainter()

    func didTapSectionTableContainer()

    func didTapRowTableContainer()
}
