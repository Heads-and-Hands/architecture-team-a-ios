//
//  InterconnectionModuleIO.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

protocol InterconnectionModuleInput {
}

protocol InterconnectionModuleOutput: class {
}

protocol InterconnectionModuleViewOutput: class {

    func didTapModuleContainer()

    func didTapScrollViewContainter()

    func didTapSectionTableContainer()

    func didTapRowTableContainer()
}
